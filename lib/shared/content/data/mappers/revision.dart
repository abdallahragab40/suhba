import 'dart:convert';

/// A short, stable fingerprint of a passage's content: 16 hex digits of
/// FNV-1a (64-bit) over its JSON. It changes when any word, citation or
/// block of the passage changes, so a saved reading position can tell
/// whether the text it was recorded against is still the same.
///
/// For change detection only; it is not a security hash. Relies on 64-bit
/// integer arithmetic (Android and iOS; not the web).
String contentRevision(Map<String, Object?> json) {
  var hash = 0xcbf29ce484222325;
  for (final byte in utf8.encode(jsonEncode(json))) {
    hash = (hash ^ byte) * 0x100000001b3;
  }
  return hash.toUnsigned(64).toRadixString(16).padLeft(16, '0');
}
