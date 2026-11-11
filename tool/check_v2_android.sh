#!/usr/bin/env bash
# Uses a separate app sandbox. Keep Flutter drive's base-ID cleanup disabled.
set -euo pipefail
v2_device="${1:-emulator-5554}"
export SUHBA_INTEGRATION_TEST=true
export SUHBA_TEST_DEVICE="$v2_device"
flutter drive --keep-app-running --no-dds \
  --driver=test_driver/v2_driver.dart \
  --target=integration_test/v2_journey_test.dart -d "$v2_device"
flutter drive --keep-app-running --profile --no-dds \
  --dart-define=SUHBA_V2_PERF_ONLY=true \
  --driver=test_driver/perf_driver.dart \
  --target=integration_test/scroll_perf_test.dart -d "$v2_device"
flutter drive --keep-app-running --no-dds \
  --driver=test_driver/share_card_driver.dart \
  --target=integration_test/share_card_smoke_test.dart -d "$v2_device"
tool/check_share_receiver.sh "$v2_device"
# Timing-sensitive real alarm checks remain opt-in; no exact-time guarantee.
if [[ "${SUHBA_CHECK_REMINDER_DELIVERY:-false}" == "true" ]]; then
  python3 tool/check_reminder_delivery.py "$v2_device"
fi
# Leave the isolated application available for inspection. Do not ask Flutter
# drive to infer an app ID to uninstall; its pre-build ID omits Gradle suffixes.
