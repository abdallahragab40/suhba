import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// App identity is generated from config/app_identity.yaml by
// tool/set_app_identity.dart. Read as UTF-8 so the Arabic name survives.
val appIdentity = Properties().apply {
    file("identity.properties").reader(Charsets.UTF_8).use { load(it) }
}

// Release signing comes from android/key.properties (never committed; see
// android/key.properties.example and docs/release.md). Without it, release
// builds are signed with the debug key: fine for an internal preview,
// rejected by the stores.
val keystoreFile = rootProject.file("key.properties")
val keystore = Properties().apply {
    if (keystoreFile.exists()) keystoreFile.reader(Charsets.UTF_8).use { load(it) }
}
val hasReleaseKey = keystoreFile.exists()

// A public build (SIYAR_PUBLIC_BUILD=true, set by the release pipeline) must
// never fall back to the debug key.
if (System.getenv("SIYAR_PUBLIC_BUILD") == "true" && !hasReleaseKey) {
    throw GradleException(
        "Public build without android/key.properties: refusing to sign with the debug key.",
    )
}

android {
    // Code namespace only; independent of the published application ID.
    namespace = "app.siyarsahaba"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    buildFeatures {
        // Needed for the generated app_name string below (off by default in AGP 9).
        resValues = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = appIdentity.getProperty("applicationId")
        resValue("string", "app_name", appIdentity.getProperty("appName"))
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasReleaseKey) {
            create("release") {
                storeFile = rootProject.file(keystore.getProperty("storeFile"))
                storePassword = keystore.getProperty("storePassword")
                keyAlias = keystore.getProperty("keyAlias")
                keyPassword = keystore.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName(if (hasReleaseKey) "release" else "debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
