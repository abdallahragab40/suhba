enum Severity { error, warning }

/// One problem found in the content, with the rule that found it.
///
/// Rules: V1 schema · V2 IDs and references · V3 citations required ·
/// V4 disputes · V5 wording and honorifics · V6 approvals · V7 content hash ·
/// V8 fitna sign-off · V9 pending locators and text · V10 Qur'an references ·
/// V11 publication closure · V12 dates.
class Issue {
  const Issue(this.rule, this.severity, this.file, this.path, this.message);

  final String rule;
  final Severity severity;
  final String file;

  /// JSON path inside [file], e.g. `$.sections[2].blocks[0]`; empty for the
  /// whole file.
  final String path;
  final String message;

  @override
  String toString() {
    final level = severity == Severity.error ? 'ERROR' : 'WARN ';
    final where = path.isEmpty ? file : '$file $path';
    return '$level $rule  $where: $message';
  }
}

class IssueSink {
  final List<Issue> issues = [];

  void error(String rule, String file, String path, String message) =>
      issues.add(Issue(rule, Severity.error, file, path, message));

  void warning(String rule, String file, String path, String message) =>
      issues.add(Issue(rule, Severity.warning, file, path, message));

  bool get hasErrors => issues.any((i) => i.severity == Severity.error);
}
