# Flutter core rules
-keep class io.flutter.** { *; }
-keep class com.example.faith_plus.** { *; }
-dontwarn io.flutter.**

# Preserve Dart-generated classes and plugins
-keep class **.GeneratedPluginRegistrant { *; }
-keep class **.FlutterFirebase** { *; }  # If using Firebase
-keep class androidx.** { *; }
-dontwarn androidx.**

# Dependency-specific rules
-keep class io.github.fredgrotts.carousel_slider.** { *; }  # For carousel_slider: ^5.1.1
-keep class com.intl.** { *; }  # For intl: ^0.20.2
-keep class com.glass_kit.** { *; }  # For glass: ^2.0.0+2 (glass_kit package)
-keep class io.flutter.plugins.fontawesomeflutter.** { *; }  # For font_awesome_flutter: ^9.2.0

# Prevent removal of classes used via reflection
-keep class * extends androidx.fragment.app.Fragment { *; }
-keep class * extends androidx.lifecycle.ViewModel { *; }
-keep class * implements androidx.lifecycle.LifecycleObserver { *; }

# Suppress warnings for irrelevant rules
-dontwarn com.google.vending.licensing.**
-dontwarn com.android.vending.licensing.**
-dontwarn android.support.**

# Optimize performance
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
-optimizationpasses 5