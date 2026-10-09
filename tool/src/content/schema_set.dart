import 'dart:convert';
import 'dart:io';

import 'package:json_schema/json_schema.dart';

/// Validates JSON against the definitions in `content/schema/content.schema.json`.
class SchemaSet {
  SchemaSet(Map<String, dynamic> contentSchema)
    : _defs = contentSchema[r'$defs'] as Map<String, dynamic>;

  factory SchemaSet.fromFile(String path) => SchemaSet(
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>,
  );

  static const defaultPath = 'content/schema/content.schema.json';

  final Map<String, dynamic> _defs;
  final _compiled = <String, JsonSchema>{};

  /// Errors from validating [instance] against the definition [def]
  /// (e.g. `companionFile`), as "path: message" strings.
  List<(String path, String message)> validate(String def, Object? instance) {
    final schema = _compiled.putIfAbsent(
      def,
      () => JsonSchema.create({
        r'$schema': 'https://json-schema.org/draft/2020-12/schema',
        r'$ref': '#/\$defs/$def',
        r'$defs': _defs,
      }),
    );
    return [
      for (final e in schema.validate(instance).errors)
        (
          e.instancePath.isEmpty ? r'$' : _toJsonPath(e.instancePath),
          e.message,
        ),
    ];
  }

  // "/sections/2/blocks/0" → "$.sections[2].blocks[0]"
  static String _toJsonPath(String pointer) {
    final out = StringBuffer(r'$');
    for (final part in pointer.split('/').skip(1)) {
      final index = int.tryParse(part);
      out.write(index != null ? '[$index]' : '.$part');
    }
    return out.toString();
  }
}
