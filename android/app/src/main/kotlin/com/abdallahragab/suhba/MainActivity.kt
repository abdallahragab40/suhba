package com.abdallahragab.suhba

import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Android 12+ fades its launch screen out over the app's first frame.
        // That frame is the opening screen, which draws the same mark in the
        // same place (lib/app/opening/opening_cover.dart), so the launch
        // screen leaves at once instead: no dimming between the two.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            splashScreen.setOnExitAnimationListener { view -> view.remove() }
        }
    }
}
