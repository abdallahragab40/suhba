import 'package:yaml/yaml.dart';

/// What the release gate requires of a built Android artifact, read from
/// `config/android_release.yaml`.
class AndroidReleasePolicy {
  const AndroidReleasePolicy({
    required this.minVersionCode,
    required this.minTargetSdk,
    required this.allowedPermissions,
    required this.forbiddenComponentPrefixes,
    required this.uploadCertificateSha256,
  });

  final int minVersionCode;
  final int minTargetSdk;

  /// May contain `{package}`, replaced by the artifact's application ID.
  final List<String> allowedPermissions;
  final List<String> forbiddenComponentPrefixes;

  /// Colon-separated upper-case hex, as keytool prints it.
  final String uploadCertificateSha256;

  AndroidReleasePolicy withMinVersionCode(int code) => AndroidReleasePolicy(
    minVersionCode: code,
    minTargetSdk: minTargetSdk,
    allowedPermissions: allowedPermissions,
    forbiddenComponentPrefixes: forbiddenComponentPrefixes,
    uploadCertificateSha256: uploadCertificateSha256,
  );
}

/// Parses `config/android_release.yaml`. Throws [FormatException] when a key
/// is missing or has the wrong type.
AndroidReleasePolicy parseAndroidReleasePolicy(String source) {
  final Object? doc = loadYaml(source);
  if (doc is! YamlMap) {
    throw const FormatException('android_release.yaml must be a YAML map.');
  }
  int integer(String key) {
    final value = doc[key];
    if (value is! int) throw FormatException('"$key" must be an integer.');
    return value;
  }

  List<String> strings(String key) {
    final value = doc[key];
    if (value is! YamlList || value.any((e) => e is! String)) {
      throw FormatException('"$key" must be a list of strings.');
    }
    return value.cast<String>().toList();
  }

  final cert = doc['uploadCertificateSha256'];
  if (cert is! String || normalizeFingerprint(cert).length != 64) {
    throw const FormatException(
      '"uploadCertificateSha256" must be a SHA-256 fingerprint.',
    );
  }
  return AndroidReleasePolicy(
    minVersionCode: integer('minVersionCode'),
    minTargetSdk: integer('minTargetSdk'),
    allowedPermissions: strings('allowedPermissions'),
    forbiddenComponentPrefixes: strings('forbiddenComponentPrefixes'),
    uploadCertificateSha256: cert,
  );
}

/// The facts the gate checks, read from a merged manifest.
class AndroidManifestFacts {
  const AndroidManifestFacts({
    required this.package,
    required this.versionCode,
    required this.versionName,
    required this.minSdk,
    required this.targetSdk,
    required this.debuggable,
    required this.permissions,
    required this.components,
  });

  final String? package;
  final int? versionCode;
  final String? versionName;
  final int? minSdk;
  final int? targetSdk;
  final bool debuggable;

  /// `uses-permission` and `uses-permission-sdk-23` names.
  final Set<String> permissions;

  /// Class names of activities, aliases, services, receivers and providers.
  final Set<String> components;
}

final _element = RegExp(r'^(\s*)E: ([\w-]+) ');
final _attribute = RegExp(
  r'^\s*A: (?:[^=]*:)?([\w-]+)(?:\(0x[0-9a-fA-F]+\))?=(.*)$',
);
final _raw = RegExp(r' \(Raw: .*\)$');

const _componentTags = {
  'activity',
  'activity-alias',
  'service',
  'receiver',
  'provider',
};

/// Parses the output of `aapt2 dump xmltree --file AndroidManifest.xml`,
/// which works for both an APK's binary manifest and a bundle's protobuf
/// manifest (`base/manifest/AndroidManifest.xml`).
AndroidManifestFacts parseAapt2XmlTree(String dump) {
  final path = <(int, String)>[]; // (indent, tag) of the open elements
  String? package;
  String? versionName;
  int? versionCode, minSdk, targetSdk;
  var debuggable = false;
  final permissions = <String>{};
  final components = <String>{};

  for (final line in dump.split('\n')) {
    final e = _element.firstMatch(line);
    if (e != null) {
      final indent = e.group(1)!.length;
      while (path.isNotEmpty && path.last.$1 >= indent) {
        path.removeLast();
      }
      path.add((indent, e.group(2)!));
      continue;
    }
    final a = _attribute.firstMatch(line);
    if (a == null || path.isEmpty) continue;
    final tag = path.last.$2;
    final parent = path.length > 1 ? path[path.length - 2].$2 : null;
    final name = a.group(1)!;
    final value = _value(a.group(2)!);
    switch ((tag, name)) {
      case ('manifest', 'package') when path.length == 1:
        package = value;
      case ('manifest', 'versionCode') when path.length == 1:
        versionCode = int.tryParse(value);
      case ('manifest', 'versionName') when path.length == 1:
        versionName = value;
      case ('uses-sdk', 'minSdkVersion') when parent == 'manifest':
        minSdk = int.tryParse(value);
      case ('uses-sdk', 'targetSdkVersion') when parent == 'manifest':
        targetSdk = int.tryParse(value);
      case ('application', 'debuggable') when parent == 'manifest':
        debuggable = value == 'true' || value == '0xffffffff';
      case ('uses-permission' || 'uses-permission-sdk-23', 'name')
          when parent == 'manifest':
        permissions.add(value);
      case (final t, 'name')
          when _componentTags.contains(t) && parent == 'application':
        components.add(value);
    }
  }
  return AndroidManifestFacts(
    package: package,
    versionCode: versionCode,
    versionName: versionName,
    minSdk: minSdk,
    targetSdk: targetSdk,
    debuggable: debuggable,
    permissions: permissions,
    components: components,
  );
}

String _value(String text) {
  var v = text.replaceFirst(_raw, '');
  if (v.length >= 2 && v.startsWith('"') && v.endsWith('"')) {
    v = v.substring(1, v.length - 1);
  }
  return v;
}

/// The signer certificates' SHA-256 fingerprints in the output of
/// `keytool -printcert -jarfile` or `apksigner verify --print-certs`,
/// normalised by [normalizeFingerprint].
List<String> parseSignerSha256(String output) => [
  for (final m in RegExp(
    r'(?:SHA256:|SHA-256 digest:)\s*([0-9A-Fa-f:]+)',
  ).allMatches(output))
    normalizeFingerprint(m.group(1)!),
];

/// Upper-case hex without separators.
String normalizeFingerprint(String fingerprint) =>
    fingerprint.replaceAll(RegExp(r'[^0-9A-Fa-f]'), '').toUpperCase();

/// `version: 2.2.0+4` in pubspec.yaml → `2.2.0`.
String pubspecVersionName(String pubspec) {
  final version = (loadYaml(pubspec) as YamlMap)['version'];
  if (version is! String) {
    throw const FormatException('pubspec.yaml has no version.');
  }
  return version.split('+').first;
}

/// Problems with a built Android artifact's manifest and signer. Empty when
/// all hold. [signers] is null when the signature is not checked (an APK
/// preview is debug-signed); an empty list means the artifact is unsigned.
List<String> androidArtifactProblems({
  required AndroidManifestFacts manifest,
  required AndroidReleasePolicy policy,
  required String expectedVersionName,
  required String expectedPackage,
  List<String>? signers,
}) {
  final problems = <String>[];
  final package = manifest.package;
  if (package != expectedPackage) {
    problems.add(
      'Application ID is "$package", expected "$expectedPackage" '
      '(config/app_identity.yaml).',
    );
  }
  final code = manifest.versionCode;
  if (code == null) {
    problems.add('The manifest has no versionCode.');
  } else if (code < policy.minVersionCode) {
    problems.add(
      'versionCode $code is below ${policy.minVersionCode} '
      '(config/android_release.yaml minVersionCode); Play rejects a code '
      'it has already seen.',
    );
  }
  if (manifest.versionName != expectedVersionName) {
    problems.add(
      'versionName is "${manifest.versionName}", expected '
      '"$expectedVersionName" (pubspec.yaml).',
    );
  }
  if (manifest.debuggable) problems.add('The artifact is debuggable.');
  final target = manifest.targetSdk;
  if (target == null || target < policy.minTargetSdk) {
    problems.add(
      'targetSdkVersion is $target, Play requires at least '
      '${policy.minTargetSdk}.',
    );
  }
  final allowed = {
    for (final p in policy.allowedPermissions)
      p.replaceAll('{package}', package ?? expectedPackage),
  };
  for (final p in manifest.permissions.toList()..sort()) {
    if (p == 'android.permission.INTERNET') {
      problems.add('Requests INTERNET: the app must stay offline.');
    } else if (!allowed.contains(p)) {
      problems.add(
        'Requests a permission not in the allowlist '
        '(config/android_release.yaml): $p',
      );
    }
  }
  for (final c in manifest.components.toList()..sort()) {
    if (policy.forbiddenComponentPrefixes.any(c.startsWith)) {
      problems.add('Contains a forbidden component: $c');
    }
  }
  if (signers != null) {
    final expected = normalizeFingerprint(policy.uploadCertificateSha256);
    if (signers.isEmpty) {
      problems.add('The artifact is not signed.');
    } else if (signers.length != 1 || signers.single != expected) {
      problems.add(
        'Signed with ${signers.join(', ')}, expected only the upload '
        'certificate $expected (config/android_release.yaml).',
      );
    }
  }
  problems.sort();
  return problems;
}
