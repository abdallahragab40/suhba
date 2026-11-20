/// Debug-only preview: the app behaves as if every item were approved and
/// the build published (no draft banners or badges, share cards on), to
/// see what a reviewed release will look like.
///
/// Turn it on with `--dart-define=SUHBA_PREVIEW_APPROVED=true` on a debug
/// build. It never writes an approval record, never touches `content/`,
/// and is always off in profile and release builds.
///
/// Pure Dart (no Flutter import): the content tools share the mappers that
/// read it and run on the plain Dart VM.
const previewApproved =
    !bool.fromEnvironment('dart.vm.product') &&
    !bool.fromEnvironment('dart.vm.profile') &&
    bool.fromEnvironment('SUHBA_PREVIEW_APPROVED');
