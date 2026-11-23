#!/usr/bin/env bash
# A real older APK -> this checkout's APK replacement; never uninstall
# between phases. See docs/android-upgrade-check.md.
#
#   tool/check_android_upgrade.sh <device> [from-ref]
#
# from-ref is the installed release to upgrade from: ae0f338 (2.0.0+2, schema
# 5, what closed testers have; the default) or 6e213d0 (1.0.0+1, schema 3).
# The seed test is chosen by its major version (upgrade_seed_v<major>_test.dart).
# The target is this checkout: its pubspec version, and the schema the
# verifier reads from AppDatabase.schemaVersion. FLUTTER selects the SDK
# (default: flutter on PATH).
set -euo pipefail
upgrade_root="$(git rev-parse --show-toplevel)"
cd "$upgrade_root"
upgrade_device="${1:?usage: tool/check_android_upgrade.sh <device> [from-ref]}"
upgrade_ref="${2:-ae0f338}"
flutter="${FLUTTER:-flutter}"
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
pubspec_version() { sed -n 's/^version: *//p' | head -1; }
upgrade_from="$(git show "$upgrade_revision:pubspec.yaml" | pubspec_version)"
upgrade_to="$(pubspec_version < pubspec.yaml)"
upgrade_from_name="${upgrade_from%%+*}" upgrade_from_code="${upgrade_from##*+}"
upgrade_to_name="${upgrade_to%%+*}" upgrade_to_code="${upgrade_to##*+}"
upgrade_seed="upgrade_seed_v${upgrade_from_name%%.*}_test.dart"
if [[ ! -f "integration_test/$upgrade_seed" ]]; then
  echo "No seed test for $upgrade_from: integration_test/$upgrade_seed" >&2
  exit 1
fi
if (( upgrade_to_code <= upgrade_from_code )); then
  echo "versionCode $upgrade_to_code does not upgrade $upgrade_from_code" >&2
  exit 1
fi
echo "Upgrade check: $upgrade_from ($upgrade_revision) -> $upgrade_to (this checkout) on $upgrade_device"
upgrade_output="$(mktemp -d "$upgrade_root/build/android-upgrade.XXXXXX")"
upgrade_tree="$(mktemp -d "${TMPDIR:-/tmp}/suhba-upgrade-from.XXXXXX")"
rmdir "$upgrade_tree"
cleanup_upgrade_tree() {
  # Only this script's detached scratch checkout is removed; retain all evidence.
  git -C "$upgrade_root" worktree remove --force "$upgrade_tree" >/dev/null 2>&1 || true
}
trap cleanup_upgrade_tree EXIT
git worktree add --detach "$upgrade_tree" "$upgrade_revision"
mkdir -p "$upgrade_tree/integration_test" "$upgrade_tree/test_driver"
cp "integration_test/$upgrade_seed" "$upgrade_tree/integration_test/"
cp test_driver/v2_driver.dart "$upgrade_tree/test_driver/"
python3 - "$upgrade_tree" <<'PY'
from pathlib import Path
import sys
root = Path(sys.argv[1])
p = root / 'android/app/build.gradle.kts'
s = p.read_text()
needle = 'applicationId = appIdentity.getProperty("applicationId")'
assert s.count(needle) == 1, 'Unexpected legacy app ID configuration'
if 'applicationIdSuffix = ".integration_test"' not in s:  # 1.0 had no isolation
    s = s.replace(needle, needle + '\n        applicationIdSuffix = ".integration_test"')
p.write_text(s)
p = root / 'pubspec.yaml'
s = p.read_text()
anchor = '  integration_test:\n    sdk: flutter'
assert anchor in s
# Declare the already-locked test dependencies only where they are missing.
extra = ''.join(f'\n  {d}' for d in ['package_info_plus: 10.2.2', 'path_provider: 2.1.6']
                if f'\n  {d.split(":")[0]}:' not in s)
s = s.replace(anchor, anchor + extra)
p.write_text(s)
PY
export SUHBA_INTEGRATION_TEST=true
(
  cd "$upgrade_tree"
  "$flutter" pub get > "$upgrade_output/from-pub.log" 2>&1
  "$flutter" build apk --debug --dart-define=SUHBA_UPGRADE_SEED=true \
    --dart-define=SUHBA_UPGRADE_FROM="$upgrade_from_name" \
    --target="integration_test/$upgrade_seed" > "$upgrade_output/from-build.log" 2>&1
)
cp "$upgrade_tree/build/app/outputs/flutter-apk/app-debug.apk" "$upgrade_output/from-seed.apk"
"$flutter" build apk --debug --dart-define=SUHBA_UPGRADE_VERIFY=true \
  --dart-define=SUHBA_UPGRADE_TO="$upgrade_to_name" \
  --target=integration_test/upgrade_verify_v2_test.dart > "$upgrade_output/to-build.log" 2>&1
cp build/app/outputs/flutter-apk/app-debug.apk "$upgrade_output/to-verify.apk"
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
for upgrade_phase in from-seed to-verify; do
  "$upgrade_tools/aapt2" dump badging "$upgrade_output/$upgrade_phase.apk" > "$upgrade_output/$upgrade_phase-manifest.txt"
  "$upgrade_tools/apksigner" verify --print-certs "$upgrade_output/$upgrade_phase.apk" > "$upgrade_output/$upgrade_phase-signature.txt"
done
python3 - "$upgrade_output" "$upgrade_revision" "$upgrade_from_name" "$upgrade_from_code" "$upgrade_to_name" "$upgrade_to_code" <<'PY'
from pathlib import Path
import hashlib, json, re, sys
root = Path(sys.argv[1])
info = []
for phase, version, code in [('from-seed', sys.argv[3], sys.argv[4]), ('to-verify', sys.argv[5], sys.argv[6])]:
    manifest = (root / f'{phase}-manifest.txt').read_text().splitlines()[0]
    assert "name='com.abdallahragab.suhba.integration_test'" in manifest, manifest
    assert f"versionName='{version}'" in manifest, manifest
    assert f"versionCode='{code}'" in manifest, manifest
    cert = sorted(set(re.findall(r'certificate SHA-256 digest: ([0-9a-fA-F]+)', (root / f'{phase}-signature.txt').read_text())))
    assert cert, 'No signer certificates reported'
    info.append({'phase': phase, 'version': version, 'versionCode': code, 'certificateSha256': cert, 'apkSha256': hashlib.sha256((root / f'{phase}.apk').read_bytes()).hexdigest()})
assert info[0]['certificateSha256'] == info[1]['certificateSha256'], 'Upgrade signatures differ'
(root / 'build-evidence.json').write_text(json.dumps({'fromCommit': sys.argv[2], 'apks': info}, indent=2) + '\n')
PY
# Explicit adb replacement must succeed. No Flutter uninstall/reinstall fallback
# can turn a failed replacement into a passing preservation check.
"$upgrade_adb" -s "$upgrade_device" install -t -r "$upgrade_output/from-seed.apk" > "$upgrade_output/from-install.log" 2>&1
(
  cd "$upgrade_tree"
  "$flutter" drive --keep-app-running --no-dds --dart-define=SUHBA_UPGRADE_SEED=true \
    --dart-define=SUHBA_UPGRADE_FROM="$upgrade_from_name" \
    --driver=test_driver/v2_driver.dart --target="integration_test/$upgrade_seed" \
    --use-application-binary="$upgrade_output/from-seed.apk" -d "$upgrade_device" > "$upgrade_output/from-test.log" 2>&1
)
grep -q "UPGRADE_SEEDED $upgrade_from_name " "$upgrade_output/from-test.log"
"$upgrade_adb" -s "$upgrade_device" shell am force-stop "$upgrade_id"
"$upgrade_adb" -s "$upgrade_device" install -t -r "$upgrade_output/to-verify.apk" > "$upgrade_output/to-install.log" 2>&1
"$flutter" drive --keep-app-running --no-dds --dart-define=SUHBA_UPGRADE_VERIFY=true \
  --dart-define=SUHBA_UPGRADE_TO="$upgrade_to_name" \
  --driver=test_driver/v2_driver.dart --target=integration_test/upgrade_verify_v2_test.dart \
  --use-application-binary="$upgrade_output/to-verify.apk" -d "$upgrade_device" > "$upgrade_output/to-test.log" 2>&1
grep -q "UPGRADE_VERIFIED $upgrade_from_name to $upgrade_to_name, .* all saved rows/anchors/scores preserved" "$upgrade_output/to-test.log"
grep -o 'UPGRADE_[A-Z]* .*' "$upgrade_output/from-test.log" "$upgrade_output/to-test.log" || true
if grep -i 'Uninstalling old version' "$upgrade_output/from-test.log" "$upgrade_output/to-test.log"; then
  echo 'Flutter attempted a destructive fallback; preservation check is not valid.' >&2
  exit 1
fi
"$upgrade_adb" -s "$upgrade_device" exec-out run-as "$upgrade_id" cat app_flutter/upgrade-snapshot.json > "$upgrade_output/seed-snapshot.json"
"$upgrade_adb" -s "$upgrade_device" uninstall "$upgrade_id" > "$upgrade_output/test-app-cleanup.log" 2>&1
printf 'Signed APK upgrade verified. Evidence: %s\n' "$upgrade_output"
