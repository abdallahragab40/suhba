import 'dart:convert';
import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() => integrationDriver(
  responseDataCallback: (data) async {
    if (data?['reminderDelivery'] == null) {
      throw StateError('No future alarm was scheduled.');
    }
    await File(
      'build/reminder-delivery-schedule.json',
    ).writeAsString(const JsonEncoder.withIndent('  ').convert(data));
  },
);
