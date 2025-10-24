plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.faith_plus"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    sourceSets {
        getByName("main") {
            java.srcDirs("src/main/kotlin")
        }
    }

    defaultConfig {
        applicationId = "com.example.faith_plus"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            storeFile = file("C:\\Users\\IFEANYI\\faith_plus.jks")
            storePassword = "faith_plus"
            keyAlias = "faith_plus"
            keyPassword = "faith_plus"
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
        getByName("debug") {
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

// IMPORTANT: Wrap everything in afterEvaluate
afterEvaluate {
    tasks.register<Copy>("copyDebugApk") {
        from(layout.buildDirectory.dir("outputs/apk/debug"))
        into(layout.projectDirectory.dir("../../build/app/outputs/flutter-apk"))
        include("*.apk")
    }

    tasks.register<Copy>("copyReleaseApk") {
        from(layout.buildDirectory.dir("outputs/apk/release"))
        into(layout.projectDirectory.dir("../../build/app/outputs/flutter-apk"))
        include("*.apk")
    }

    tasks.named("assembleDebug") {
        finalizedBy("copyDebugApk")
    }

    tasks.named("assembleRelease") {
        finalizedBy("copyReleaseApk")
    }
}