/// Riverpod's retry policy for this app: never retry automatically.
///
/// Content comes from bundled assets, so a failure (missing file, bad data)
/// does not fix itself with time; error views offer an explicit retry that
/// invalidates the provider instead.
Duration? noAutomaticRetry(int retryCount, Object error) => null;
