// android/app/build.gradle

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")        // ← Firebase Services plugin
}

android {
    namespace = "com.clarxc.clarxcore_app"

    compileSdk = 35

    defaultConfig {
        applicationId = "com.clarxc.clarxcore_app"
        minSdk = 24
        targetSdk = 35
        versionCode = 1
        versionName = "1.0.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // AndroidX AppCompat
    implementation("androidx.appcompat:appcompat:1.4.0")

    // Firebase SDK’ları
    implementation("com.google.firebase:firebase-analytics:20.1.0")
    implementation("com.google.firebase:firebase-auth:21.0.1")
    implementation("com.google.firebase:firebase-firestore:24.0.0")
}
