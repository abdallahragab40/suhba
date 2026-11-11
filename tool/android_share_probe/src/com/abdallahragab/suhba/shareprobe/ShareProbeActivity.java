package com.abdallahragab.suhba.shareprobe;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import java.io.InputStream;

/** Test-only offline receiver. Reads the granted URI in memory, never saves it. */
public final class ShareProbeActivity extends Activity {
    @Override
    public void onCreate(Bundle state) {
        super.onCreate(state);
        try {
            Intent intent = getIntent();
            if (!Intent.ACTION_SEND.equals(intent.getAction()) ||
                    !"image/png".equals(intent.getType())) {
                throw new IllegalStateException("Unexpected action or MIME type");
            }
            String subject = intent.getStringExtra(Intent.EXTRA_SUBJECT);
            if (subject == null || !subject.matches("Suhba card smoke test [0-9]+")) {
                throw new IllegalStateException("Missing test nonce");
            }
            String nonce = subject.substring(subject.lastIndexOf(' ') + 1);
            Uri uri = intent.getParcelableExtra(Intent.EXTRA_STREAM);
            if (uri == null || !"content".equals(uri.getScheme()) ||
                    uri.getAuthority() == null ||
                    !uri.getAuthority().startsWith("com.abdallahragab.suhba.integration_test.")) {
                throw new IllegalStateException("Expected a test-app content URI");
            }
            try (InputStream stream = getContentResolver().openInputStream(uri)) {
                Bitmap image = BitmapFactory.decodeStream(stream);
                if (image == null) throw new IllegalStateException("PNG could not be decoded");
                int width = image.getWidth();
                int height = image.getHeight();
                image.recycle();
                if (width != 1080 || height != 1080) {
                    throw new IllegalStateException("Unexpected card dimensions");
                }
                Log.i("SuhbaShareProbe", "SHARE_PROBE_PASSED nonce=" + nonce + " mime=image/png width=1080 height=1080");
                setResult(RESULT_OK);
            }
        } catch (Exception error) {
            Log.e("SuhbaShareProbe", "SHARE_PROBE_FAILED", error);
            setResult(RESULT_CANCELED);
        } finally {
            finish();
        }
    }
}
