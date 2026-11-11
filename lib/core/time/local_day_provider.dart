import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/database/database_provider.dart';

/// Refreshes at local midnight and on resume, including after a timezone
/// change. Tests use the app's existing fixed clock.
final localDayProvider = NotifierProvider<LocalDayController, DateTime>(
  LocalDayController.new,
);

class LocalDayController extends Notifier<DateTime>
    with WidgetsBindingObserver {
  Timer? _timer;
  late DateTime Function() _clock;

  @override
  DateTime build() {
    _clock = ref.watch(clockProvider);
    WidgetsBinding.instance.addObserver(this);
    ref.onDispose(() {
      _timer?.cancel();
      WidgetsBinding.instance.removeObserver(this);
    });
    final now = _clock().toLocal();
    _schedule(now);
    return DateTime(now.year, now.month, now.day);
  }

  void _schedule(DateTime now) {
    _timer?.cancel();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    _timer = Timer(midnight.difference(now), refresh);
  }

  void refresh() {
    final now = _clock().toLocal();
    state = DateTime(now.year, now.month, now.day);
    _schedule(now);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) refresh();
  }
}
