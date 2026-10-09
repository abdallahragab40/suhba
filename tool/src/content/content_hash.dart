import 'dart:convert';

import 'package:crypto/crypto.dart';

/// JSON with object keys sorted at every level, so the same data always
/// produces the same text regardless of formatting or key order.
String canonicalJson(Object? value) {
  if (value is Map) {
    final keys = value.keys.cast<String>().toList()..sort();
    return '{${keys.map((k) => '${jsonEncode(k)}:${canonicalJson(value[k])}').join(',')}}';
  }
  if (value is List) return '[${value.map(canonicalJson).join(',')}]';
  return jsonEncode(value);
}

/// The hash a reviewer approves: SHA-256 of the item's canonical JSON,
/// excluding its `review` block (status changes do not alter the content).
String contentHash(Map<String, dynamic> item) {
  final content = Map<String, dynamic>.of(item)..remove('review');
  return sha256.convert(utf8.encode(canonicalJson(content))).toString();
}
