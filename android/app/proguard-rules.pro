#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn android.window.BackEvent
-keep class android.window.BackEvent
#-keep classmembernames class android.window.BackEvent

-dontwarn okhttp3.internal.platform.** -dontwarn org.conscrypt.** -dontwarn org.bouncycastle.** -dontwarn org.openjsse.**

-dontwarn com.google.protobuf.java_com_google_android_gmscore_sdk_target_granule__proguard_group_gtm_N1281923064GeneratedExtensionRegistryLite**

-keep,allowobfuscation,allowshrinking class kotlin.coroutines.Continuation

 ## Flutter wrapper
 -keep class io.flutter.app.** { *; }
 -keep class io.flutter.plugin.** { *; }
 -keep class io.flutter.util.** { *; }
 -keep class io.flutter.view.** { *; }
 -keep class io.flutter.** { *; }
 -keep class io.flutter.plugins.** { *; }
 -keep class com.google.firebase.** { *; }
 -dontwarn io.flutter.embedding.**
 -ignorewarnings

 #
 -dontwarn java.nio.file.Files
 -dontwarn java.nio.file.Path
 -dontwarn java.nio.file.OpenOption
 -dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement

 #
 -keepclassmembers class io.flutter.embedding.android.FlutterActivity.** { *; }