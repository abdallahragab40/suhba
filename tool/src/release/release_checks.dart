import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:suhba/shared/content/domain/content_format.dart';
import 'package:suhba/shared/content/domain/review.dart';

import '../app_identity.dart';
import '../content/readiness.dart';

/// What must hold before a public artifact is built: the final identity,
/// content that builds on the published channel, and the complete edition
/// (content/release/edition.json). Empty when all hold.
List<String> preBuildProblems({
  required AppIdentity identity,
  required ReadinessReport readiness,
}) => [
  for (final e in validateAppIdentity(identity, release: true)) 'Identity: $e',
  for (final e in readiness.publishedBuildErrors) 'Published content: $e',
  for (final p in readiness.editionProblems) 'Edition: $p',
];

/// Checks the content bundled inside a built artifact.
///
/// [bundled] maps paths relative to the content root (`manifest.json`,
/// `companions/abu-bakr.json`, …) to file contents. The manifest must be of
/// [channel] and [contentVersion], in a supported format, with nothing
/// unapproved if published, and every file must match its listed hash, with
/// none missing or extra. [requiredJourneyIds] also enforces the launch
/// journeys and their catalog entries; published journey records must be approved.
List<String> artifactProblems({
  required Map<String, String> bundled,
  required ContentChannel channel,
  required String contentVersion,
  List<String> requiredJourneyIds = const [],
}) {
  final text = bundled['manifest.json'];
  if (text == null) return ['No content manifest in the artifact.'];
  final Map<String, dynamic> manifest;
  try {
    manifest = jsonDecode(text) as Map<String, dynamic>;
  } on FormatException catch (e) {
    return ['The content manifest is not valid JSON: ${e.message}'];
  }

  final problems = <String>[];
  if (!ContentFormat.supported.contains(manifest['schemaVersion'])) {
    problems.add(
      'Content schema version ${manifest['schemaVersion']} is not one this '
      'app reads (${ContentFormat.supported}).',
    );
  }
  if (manifest['channel'] != channel.name) {
    problems.add(
      'Content channel is "${manifest['channel']}", expected '
      '"${channel.name}".',
    );
  }
  if (channel == ContentChannel.published && manifest['unapprovedCount'] != 0) {
    problems.add(
      'Published content contains ${manifest['unapprovedCount']} '
      'unapproved items.',
    );
  }
  if (manifest['contentVersion'] != contentVersion) {
    problems.add(
      'Content version is "${manifest['contentVersion']}", expected '
      '"$contentVersion" (content/meta.json).',
    );
  }

  final listed = (manifest['files'] as Map<String, dynamic>? ?? const {})
      .cast<String, String>();
  for (final MapEntry(key: path, value: hash) in listed.entries) {
    final file = bundled[path];
    if (file == null) {
      problems.add('Missing from the artifact: $path');
    } else if (sha256.convert(utf8.encode(file)).toString() != hash) {
      problems.add('Does not match its manifest hash: $path');
    }
  }
  for (final path in bundled.keys) {
    if (path != 'manifest.json' && !listed.containsKey(path)) {
      problems.add('Not listed in the manifest: $path');
    }
  }
  if (requiredJourneyIds.isNotEmpty) {
    final indexText = bundled['index/journeys.json'];
    final index = indexText == null ? null : _jsonObject(indexText);
    final ids = index?['journeyIds'];
    if (ids is! List || ids.any((id) => id is! String)) {
      problems.add('Required journey index is missing or malformed.');
    }
    for (final id in requiredJourneyIds) {
      if (ids is List && !ids.contains(id)) {
        problems.add('Required journey is absent from the index: $id');
      }
      final path = 'journeys/$id.json';
      final text = bundled[path];
      if (text == null) {
        problems.add('Required journey is missing from the artifact: $id');
        continue;
      }
      final journey = _jsonObject(text);
      if (journey == null || journey['id'] != id) {
        problems.add(
          'Required journey record is malformed or has the wrong id: $id',
        );
      } else if (channel == ContentChannel.published) {
        final review = journey['review'];
        if (review is! Map || review['status'] != 'approved') {
          problems.add('Required published journey is not approved: $id');
        }
      }
    }
  }
  problems.sort();
  return problems;
}

/// Where Flutter puts bundled content inside an APK, AAB or IPA.
final contentEntry = RegExp(
  r'(?:^|/)flutter_assets/assets/content/(.+\.json)$',
);

Map<String, dynamic>? _jsonObject(String text) {
  try {
    final value = jsonDecode(text);
    return value is Map<String, dynamic> ? value : null;
  } on FormatException {
    return null;
  }
}
