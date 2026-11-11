import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/database/database_provider.dart';
import 'package:suhba/core/time/local_day_provider.dart';

void main() {
  testWidgets('the local day refreshes at midnight and after resume', (
    tester,
  ) async {
    var now = DateTime(2026, 11, 9, 23, 59, 59);
    final container = ProviderContainer(
      overrides: [clockProvider.overrideWithValue(() => now.toUtc())],
    );
    expect(container.read(localDayProvider), DateTime(2026, 11, 9));
    now = DateTime(2026, 11, 10, 0, 0, 1);
    await tester.pump(const Duration(seconds: 2));
    expect(container.read(localDayProvider), DateTime(2026, 11, 10));
    now = DateTime(2026, 11, 12, 8);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    expect(container.read(localDayProvider), DateTime(2026, 11, 12));
    container.dispose();
  });
}
