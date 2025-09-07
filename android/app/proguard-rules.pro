# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# Keep Google Generative AI classes
-keep class com.google.ai.** { *; }
-keep class com.google.generativeai.** { *; }
-keep class com.google.firebase.** { *; }

# Keep all classes that might be used for reflection
-keep class * extends com.google.protobuf.GeneratedMessageLite { *; }

# Keep HTTP client classes
-keep class okhttp3.** { *; }
-keep class retrofit2.** { *; }

# Keep JSON parsing classes
-keep class com.google.gson.** { *; }
-keep class org.json.** { *; }
