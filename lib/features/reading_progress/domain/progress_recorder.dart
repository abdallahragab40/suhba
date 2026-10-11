import 'dart:async';

import 'package:suhba/shared/content/domain/passage_position.dart';

/// Batches reading positions so storage sees at most one write per
/// [interval]: the first report starts the interval, later reports replace
/// the pending value, and the last one is written when it ends.
///
/// Call [flush] when the reader closes or the app goes to the background.
///
/// Completion: scrolling to [completionThreshold] of a passage marks it
/// finished. A passage too short to scroll is never finished by opening it;
/// the reader finishes it explicitly ([markCompleted]).
class ProgressRecorder {
  ProgressRecorder({
    required this.save,
    this.onError,
    this.interval = const Duration(milliseconds: 1500),
  });

  /// Writes a position; [completed] once the passage was finished.
  final Future<void> Function(PassagePosition position, bool completed) save;

  /// Called when a write fails. The position stays pending, so the next
  /// report or [flush] tries again.
  final void Function(Object error, StackTrace stackTrace)? onError;
  final Duration interval;

  /// Reaching this share of the text counts as finishing it.
  static const completionThreshold = 0.95;

  Timer? _timer;
  PassagePosition? _pending;
  PassagePosition _last = PassagePosition.start;
  bool _completed = false;

  void report(PassagePosition position) {
    _pending = _last = PassagePosition(
      fraction: position.fraction.clamp(0, 1),
      blockIndex: position.blockIndex,
      blockOffset: position.blockOffset,
    );
    if (position.fraction >= completionThreshold) _completed = true;
    _timer ??= Timer(interval, flush);
  }

  /// Finishes the passage at the last known position and writes it now.
  Future<void> markCompleted() {
    _completed = true;
    _pending = _last;
    return flush();
  }

  /// Forgets everything recorded so far (the reader starts over); nothing
  /// pending is written.
  void reset() {
    _timer?.cancel();
    _timer = null;
    _pending = null;
    _last = PassagePosition.start;
    _completed = false;
  }

  /// Writes the pending position now, if any.
  Future<void> flush() async {
    _timer?.cancel();
    _timer = null;
    final position = _pending;
    if (position == null) return;
    _pending = null;
    try {
      await save(position, _completed);
    } on Object catch (error, stackTrace) {
      // Keep it for the next attempt unless a newer position arrived.
      _pending ??= position;
      onError?.call(error, stackTrace);
    }
  }
}
