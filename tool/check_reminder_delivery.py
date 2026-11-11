#!/usr/bin/env python3
"""Observe a real future notification without requiring a live app process."""
import datetime
import json
import os
import re
from pathlib import Path
import shlex
import subprocess
import sys
import time

root = Path(__file__).resolve().parent.parent
os.chdir(root)
device = sys.argv[1] if len(sys.argv) > 1 else 'emulator-5554'
sdk = Path(os.environ.get('ANDROID_HOME', os.environ.get('ANDROID_SDK_ROOT', str(Path.home() / 'Library/Android/sdk'))))
adb = [str(sdk / 'platform-tools/adb'), '-s', device]
app = 'com.abdallahragab.suhba.delivery_test'
observe_minutes = float(os.environ.get('SUHBA_REMINDER_OBSERVE_MINUTES', '20'))
if not 0 < observe_minutes <= 120:
    raise SystemExit('Observation budget must be between 0 and 120 minutes.')
output = root / 'build/reminder-delivery'
output.mkdir(parents=True, exist_ok=True)

def shell(*args):
    return subprocess.run(adb + ['shell', shlex.join(args)], check=True,
                          capture_output=True, text=True).stdout.strip()

def logged(command, name, env=None):
    with (output / name).open('w') as log:
        subprocess.run(command, check=True, stdout=log, stderr=subprocess.STDOUT, env=env)

subprocess.run(adb + ['get-state'], check=True, capture_output=True)
existing = subprocess.run(adb + ['shell', 'pm', 'path', app], capture_output=True, text=True)
if 'package:' in existing.stdout:
    raise SystemExit('The delivery sandbox is occupied; inspect/remove only that test app first.')
# Never leave a stale positive result if a later run fails.
for generated in ['result.json', 'notification.txt', 'next-alarm.txt']:
    (output / generated).unlink(missing_ok=True)
(root / 'build/reminder-delivery-schedule.json').unlink(missing_ok=True)
env = dict(os.environ, SUHBA_REMINDER_DELIVERY_TEST='true')
owned = False
try:
    logged(['flutter', 'build', 'apk', '--debug', '--dart-define=SUHBA_REMINDER_DELIVERY=true',
            '--target=integration_test/reminder_delivery_test.dart'], 'build.log', env)
    apk = root / 'build/app/outputs/flutter-apk/app-debug.apk'
    # Preflight the compiled package, not Flutter's cached pre-build identity.
    tools = sorted((sdk / 'build-tools').glob('*/aapt2'))[-1]
    manifest = subprocess.check_output([str(tools), 'dump', 'badging', str(apk)], text=True)
    if f"name='{app}'" not in manifest.splitlines()[0]:
        raise RuntimeError('Refusing to install an APK outside the delivery sandbox.')
    logged(adb + ['install', '-t', '-r', str(apk)], 'install.log')
    if 'Success' not in (output / 'install.log').read_text():
        raise RuntimeError('The delivery APK did not install successfully.')
    owned = True
    if int(shell('getprop', 'ro.build.version.sdk')) >= 33:
        shell('pm', 'grant', app, 'android.permission.POST_NOTIFICATIONS')
    logged(['flutter', 'drive', '--keep-app-running', '--no-dds',
            '--dart-define=SUHBA_REMINDER_DELIVERY=true',
            '--driver=test_driver/reminder_delivery_driver.dart',
            '--target=integration_test/reminder_delivery_test.dart',
            f'--use-application-binary={apk}', '-d', device], 'schedule.log', env)
    data = json.loads((root / 'build/reminder-delivery-schedule.json').read_text())['reminderDelivery']
    scheduled = datetime.datetime.fromisoformat(data['scheduledUtc'].replace('Z', '+00:00'))
    shell('input', 'keyevent', 'KEYCODE_HOME')
    time.sleep(1)
    # Signal only this debug sandbox's own UID. Unlike force-stop, process
    # death leaves its AlarmManager PendingIntent eligible for delivery.
    process = subprocess.run(adb + ['shell', 'pidof', app], capture_output=True, text=True)
    pids = process.stdout.split()
    for pid in pids:
        if not pid.isdigit():
            raise RuntimeError('Unexpected test process ID.')
        shell('run-as', app, 'kill', '-9', pid)
    time.sleep(1)
    remaining = subprocess.run(adb + ['shell', 'pidof', app], capture_output=True, text=True).stdout.strip()
    if remaining:
        raise RuntimeError('The test app did not exit before delivery observation.')
    print('Future alarm scheduled; test process exit verified, observing Android.', flush=True)
    deadline = time.monotonic() + observe_minutes * 60
    while time.monotonic() < deadline:
        keys = shell('cmd', 'notification', 'list').splitlines()
        key = next((k.strip() for k in keys if f'|{app}|{data["notificationId"]}|' in k), None)
        if key:
            record = shell('cmd', 'notification', 'get', key)
            if data['title'] not in record:
                raise RuntimeError('The notification has an unexpected title.')
            alarms = shell('dumpsys', 'alarm')
            # A repeating notification must have queued the next daily alarm.
            match = re.search(r'(?m)^    RTC_WAKEUP #\d+: Alarm\{[^\n]*' + re.escape(app) + r'\}[^\n]*', alarms)
            recurring = None
            if match:
                lines = alarms[match.start():].splitlines()
                block = [lines[0]]
                for line in lines[1:]:
                    if not line.startswith('      '):
                        break
                    block.append(line)
                recurring = '\n'.join(block)
            if recurring is None or 'ScheduledNotificationReceiver' not in recurring:
                time.sleep(1)
                continue
            trigger = re.search(r'origWhen=(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})', recurring)
            offset = shell('date', '+%z')
            if trigger is None or not re.fullmatch(r'[+-]\d{4}', offset):
                raise RuntimeError('The next alarm time could not be checked.')
            minutes = (int(offset[1:3]) * 60 + int(offset[3:])) * (1 if offset[0] == '+' else -1)
            local = scheduled.astimezone(datetime.timezone(datetime.timedelta(minutes=minutes)))
            expected_day = local.date() + datetime.timedelta(days=1)
            next_local = datetime.datetime.fromisoformat(trigger.group(1))
            if next_local.date() != expected_day or (next_local.hour, next_local.minute) != (local.hour, local.minute):
                time.sleep(1)
                continue
            (output / 'notification.txt').write_text(record + '\n')
            # Store only this app's alarm block, excluding unrelated app data.
            (output / 'next-alarm.txt').write_text(recurring + '\n')
            observed = datetime.datetime.fromisoformat(shell('date', '-u', '+%Y-%m-%dT%H:%M:%SZ').replace('Z', '+00:00'))
            data.update({'observedUtc': observed.isoformat(),
                         'delayAfterScheduledSeconds': (observed - scheduled).total_seconds(),
                         'processExitedBeforeDelivery': True, 'sourceProcessIds': pids, 'nextDailyAlarm': True,
                         'sdk': shell('getprop', 'ro.build.version.sdk'),
                         'observerBudgetMinutes': observe_minutes})
            (output / 'result.json').write_text(json.dumps(data, indent=2) + '\n')
            print('Scheduled notification delivered; next daily alarm found.', flush=True)
            break
        time.sleep(2)
    else:
        raise RuntimeError(f'No scheduled notification observed within the {observe_minutes:g}-minute harness budget.')
finally:
    if owned:
        # Only this run's initially absent test package is removed. Android then
        # clears its active notification, recurring alarm and temporary data.
        subprocess.run(adb + ['uninstall', app], check=True, capture_output=True)
