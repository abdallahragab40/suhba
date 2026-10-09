import 'package:integration_test/integration_test_driver.dart';

/// Host side of integration_test/scroll_perf_test.dart: writes the frame
/// summaries to build/integration_response_data.json.
Future<void> main() => integrationDriver();
