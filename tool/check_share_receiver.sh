#!/usr/bin/env bash
# Selects only a test-owned offline Android receiver. Never shares to a person.
set -euo pipefail
probe_root="$(git rev-parse --show-toplevel)"
cd "$probe_root"
probe_device="${1:-emulator-5554}"
probe_sdk="${ANDROID_HOME:-${ANDROID_SDK_ROOT:-$HOME/Library/Android/sdk}}"
probe_adb="$probe_sdk/platform-tools/adb"
probe_id='com.abdallahragab.suhba.share_probe'
probe_existing="$("$probe_adb" -s "$probe_device" shell pm path "$probe_id" || true)"
if [[ "$probe_existing" == *package:* ]]; then
  echo 'The probe sandbox is occupied; inspect/remove only that test app first.' >&2
  exit 1
fi
rm -f "$probe_root/build/share-receiver-result.json"
tool/build_share_probe.sh
"$probe_adb" -s "$probe_device" install -t -r build/android-share-probe/share-probe.apk
trap '"$probe_adb" -s "$probe_device" uninstall "$probe_id" >/dev/null 2>&1 || true' EXIT
SUHBA_INTEGRATION_TEST=true SUHBA_TEST_DEVICE="$probe_device" flutter drive \
  --keep-app-running --no-dds --dart-define=SUHBA_SHARE_PROBE=true \
  --driver=test_driver/share_card_receiver_driver.dart \
  --target=integration_test/share_card_smoke_test.dart -d "$probe_device"
