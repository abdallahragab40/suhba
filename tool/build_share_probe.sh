#!/usr/bin/env bash
# Builds a tiny offline receiving app using installed Android SDK tools only.
set -euo pipefail
probe_root="$(git rev-parse --show-toplevel)"
probe_sdk="${ANDROID_HOME:-${ANDROID_SDK_ROOT:-$HOME/Library/Android/sdk}}"
probe_java="${JAVA_HOME:-/Applications/Android Studio.app/Contents/jbr/Contents/Home}"
probe_out="$probe_root/build/android-share-probe"
probe_tools="$(python3 - "$probe_sdk" <<'PY'
from pathlib import Path
import sys
paths = list((Path(sys.argv[1]) / 'build-tools').glob('*/aapt2'))
assert paths
print(sorted(paths)[-1].parent)
PY
)"
probe_jar="$probe_sdk/platforms/android-36/android.jar"
mkdir -p "$probe_out/classes" "$probe_out/dex"
"$probe_java/bin/javac" -encoding UTF-8 -source 17 -target 17 -classpath "$probe_jar" \
  -d "$probe_out/classes" "$probe_root/tool/android_share_probe/src/com/abdallahragab/suhba/shareprobe/ShareProbeActivity.java"
JAVA_HOME="$probe_java" "$probe_tools/d8" --lib "$probe_jar" --min-api 24 \
  --output "$probe_out/dex" "$probe_out/classes/com/abdallahragab/suhba/shareprobe/ShareProbeActivity.class"
"$probe_tools/aapt2" link -I "$probe_jar" \
  --manifest "$probe_root/tool/android_share_probe/AndroidManifest.xml" \
  -o "$probe_out/unsigned.apk"
(cd "$probe_out/dex" && zip -q -j "$probe_out/unsigned.apk" classes.dex)
"$probe_tools/zipalign" -f -p 4 "$probe_out/unsigned.apk" "$probe_out/aligned.apk"
JAVA_HOME="$probe_java" "$probe_tools/apksigner" sign --ks "$HOME/.android/debug.keystore" \
  --ks-key-alias androiddebugkey --ks-pass pass:android --key-pass pass:android \
  --out "$probe_out/share-probe.apk" "$probe_out/aligned.apk"
"$probe_tools/aapt2" dump badging "$probe_out/share-probe.apk" > "$probe_out/manifest.txt"
"$probe_tools/aapt2" dump permissions "$probe_out/share-probe.apk" > "$probe_out/permissions.txt"
python3 - "$probe_out" <<'PYVERIFY'
from pathlib import Path
import sys
root = Path(sys.argv[1])
assert "name='com.abdallahragab.suhba.share_probe'" in (root / 'manifest.txt').read_text().splitlines()[0], 'Unexpected probe application ID'
assert 'uses-permission' not in (root / 'permissions.txt').read_text(), 'The offline fixture must have no permissions'
PYVERIFY
printf 'Offline share probe: %s\n' "$probe_out/share-probe.apk"
