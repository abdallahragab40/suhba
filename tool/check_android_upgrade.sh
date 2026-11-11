#!/usr/bin/env bash
# A real 1.0 APK -> 2.0 APK replacement; never uninstall between phases.
set -euo pipefail
upgrade_root="$(git rev-parse --show-toplevel)"
cd "$upgrade_root"
upgrade_device="${1:-emulator-5554}"
upgrade_ref="${2:-6e213d0}"
upgrade_sdk="${ANDROID_HOME:-${ANDROID_SDK_ROOT:-$HOME/Library/Android/sdk}}"
upgrade_adb="$upgrade_sdk/platform-tools/adb"
upgrade_id='com.abdallahragab.suhba.integration_test'
"$upgrade_adb" -s "$upgrade_device" get-state >/dev/null
mkdir -p "$upgrade_root/build"
upgrade_existing="$("$upgrade_adb" -s "$upgrade_device" shell pm path "$upgrade_id" || true)"
if [[ "$upgrade_existing" == *package:* ]]; then
  echo 'The isolated test app is already installed. Use a fresh emulator or inspect/remove only that test app before running this check.' >&2
  exit 1
fi
upgrade_revision="$(git rev-parse --verify --end-of-options "$upgrade_ref^{commit}")"
upgrade_output="$(mktemp -d "$upgrade_root/build/android-upgrade.XXXXXX")"
upgrade_tree="$(mktemp -d "${TMPDIR:-/tmp}/suhba-v1-upgrade.XXXXXX")"
rmdir "$upgrade_tree"
cleanup_upgrade_tree() {
  # Only this script's detached scratch checkout is removed; retain all evidence.
  git -C "$upgrade_root" worktree remove --force "$upgrade_tree" >/dev/null 2>&1 || true
}
trap cleanup_upgrade_tree EXIT
git worktree add --detach "$upgrade_tree" "$upgrade_revision"
mkdir -p "$upgrade_tree/integration_test" "$upgrade_tree/test_driver"
cp integration_test/upgrade_seed_v1_test.dart "$upgrade_tree/integration_test/"
cp test_driver/v2_driver.dart "$upgrade_tree/test_driver/"
python3 - "$upgrade_tree" <<'PY'
from pathlib import Path
import sys
root = Path(sys.argv[1])
p = root / 'android/app/build.gradle.kts'
s = p.read_text()
needle = 'applicationId = appIdentity.getProperty("applicationId")'
assert s.count(needle) == 1, 'Unexpected legacy app ID configuration'
s = s.replace(needle, needle + '\n        applicationIdSuffix = ".integration_test"')
p.write_text(s)
p = root / 'pubspec.yaml'
s = p.read_text()
assert '  integration_test:\n    sdk: flutter' in s
s = s.replace('  integration_test:\n    sdk: flutter', '  integration_test:\n    sdk: flutter\n  package_info_plus: 10.2.2\n  path_provider: 2.1.6')
p.write_text(s)
PY
export SUHBA_INTEGRATION_TEST=true
(
  cd "$upgrade_tree"
  flutter pub get > "$upgrade_output/v1-pub.log" 2>&1
  flutter build apk --debug --dart-define=SUHBA_UPGRADE_SEED=true \
    --target=integration_test/upgrade_seed_v1_test.dart > "$upgrade_output/v1-build.log" 2>&1
)
cp "$upgrade_tree/build/app/outputs/flutter-apk/app-debug.apk" "$upgrade_output/v1-seed.apk"
flutter build apk --debug --dart-define=SUHBA_UPGRADE_VERIFY=true \
  --target=integration_test/upgrade_verify_v2_test.dart > "$upgrade_output/v2-build.log" 2>&1
cp build/app/outputs/flutter-apk/app-debug.apk "$upgrade_output/v2-verify.apk"
# Inspect both APK identities and certificates before installing either one.
upgrade_tools="$(python3 - "$upgrade_sdk" <<'PY'
from pathlib import Path
import sys
paths = list((Path(sys.argv[1]) / 'build-tools').glob('*/aapt2'))
assert paths, 'Android build tools are required'
print(sorted(paths)[-1].parent)
PY
)"
if [[ -z "${JAVA_HOME:-}" && -d '/Applications/Android Studio.app/Contents/jbr/Contents/Home' ]]; then
  export JAVA_HOME='/Applications/Android Studio.app/Contents/jbr/Contents/Home'
fi
for upgrade_phase in v1-seed v2-verify; do
  "$upgrade_tools/aapt2" dump badging "$upgrade_output/$upgrade_phase.apk" > "$upgrade_output/$upgrade_phase-manifest.txt"
  "$upgrade_tools/apksigner" verify --print-certs "$upgrade_output/$upgrade_phase.apk" > "$upgrade_output/$upgrade_phase-signature.txt"
done
python3 - "$upgrade_output" "$upgrade_revision" <<'PY'
from pathlib import Path
import hashlib, json, re, sys
root = Path(sys.argv[1])
info = []
for phase, version, code in [('v1-seed', '1.0.0', '1'), ('v2-verify', '2.0.0', '2')]:
    manifest = (root / f'{phase}-manifest.txt').read_text().splitlines()[0]
    assert "name='com.abdallahragab.suhba.integration_test'" in manifest, manifest
    assert f"versionName='{version}'" in manifest, manifest
    assert f"versionCode='{code}'" in manifest, manifest
    cert = sorted(set(re.findall(r'certificate SHA-256 digest: ([0-9a-fA-F]+)', (root / f'{phase}-signature.txt').read_text())))
    assert cert, 'No signer certificates reported'
    info.append({'phase': phase, 'version': version, 'versionCode': code, 'certificateSha256': cert, 'apkSha256': hashlib.sha256((root / f'{phase}.apk').read_bytes()).hexdigest()})
assert info[0]['certificateSha256'] == info[1]['certificateSha256'], 'Upgrade signatures differ'
(root / 'build-evidence.json').write_text(json.dumps({'legacyCommit': sys.argv[2], 'apks': info}, indent=2) + '\n')
PY
# Explicit adb replacement must succeed. No Flutter uninstall/reinstall fallback
# can turn a failed replacement into a passing preservation check.
"$upgrade_adb" -s "$upgrade_device" install -t -r "$upgrade_output/v1-seed.apk" > "$upgrade_output/v1-install.log" 2>&1
(
  cd "$upgrade_tree"
  flutter drive --keep-app-running --no-dds --dart-define=SUHBA_UPGRADE_SEED=true \
    --driver=test_driver/v2_driver.dart --target=integration_test/upgrade_seed_v1_test.dart \
    --use-application-binary="$upgrade_output/v1-seed.apk" -d "$upgrade_device" > "$upgrade_output/v1-test.log" 2>&1
)
rg -q 'UPGRADE_V1_SEEDED 6 bookmarks, 4 positions, 3 quiz best scores' "$upgrade_output/v1-test.log"
"$upgrade_adb" -s "$upgrade_device" shell am force-stop "$upgrade_id"
"$upgrade_adb" -s "$upgrade_device" install -t -r "$upgrade_output/v2-verify.apk" > "$upgrade_output/v2-install.log" 2>&1
flutter drive --keep-app-running --no-dds --dart-define=SUHBA_UPGRADE_VERIFY=true \
  --driver=test_driver/v2_driver.dart --target=integration_test/upgrade_verify_v2_test.dart \
  --use-application-binary="$upgrade_output/v2-verify.apk" -d "$upgrade_device" > "$upgrade_output/v2-test.log" 2>&1
rg -q 'UPGRADE_V2_VERIFIED schema 3 to 5, all saved rows/anchors/scores preserved' "$upgrade_output/v2-test.log"
if rg -i 'Uninstalling old version' "$upgrade_output/v1-test.log" "$upgrade_output/v2-test.log"; then
  echo 'Flutter attempted a destructive fallback; preservation check is not valid.' >&2
  exit 1
fi
"$upgrade_adb" -s "$upgrade_device" exec-out run-as "$upgrade_id" cat app_flutter/v1-upgrade-snapshot.json > "$upgrade_output/seed-snapshot.json"
"$upgrade_adb" -s "$upgrade_device" uninstall "$upgrade_id" > "$upgrade_output/test-app-cleanup.log" 2>&1
printf 'Signed APK upgrade verified. Evidence: %s\n' "$upgrade_output"
