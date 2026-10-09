/// The bundled-content format contract (see docs/content-format.md).
///
/// Every bundled file carries a top-level `schemaVersion`. The build tool
/// writes [current]; the app reads only versions in [supported] and fails
/// with an `UnsupportedFormatFailure` for anything else, before mapping.
///
/// Adding a version to [supported] requires a migration from it to the
/// current models and a fixture that proves the migration; there is none
/// today, so only the current version is accepted.
abstract final class ContentFormat {
  static const current = 1;
  static const supported = {current};
}
