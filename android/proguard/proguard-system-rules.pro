#=================================================================================================== =======================#

# Code confusion compression ratio, between 0~7, the default is 5, generally do not need to change
-optimizationpasses 5

# confused when not using mixed case, the confused class name is lowercase
-dontusemixedcaseclassnames

# Specify a class that does not ignore non-public libraries
-dontskipnonpubliclibraryclasses

# Specify members of classes that do not ignore non-public libraries
-dontskipnonpubliclibraryclassmembers

# Do not pre-verify, can speed up confusion
# preverify is one of the 4 steps of proguard
#Android does not need preverify, remove this step can speed up the confusion
-dontpreverify

# Do not optimize the input class file
-dontoptimize

# When generating a log file, that is, a mapping file
-verbose

# Specify the name of the mapping file
-printmapping proguardMapping.txt

# Algorithm used in confusion
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*


# Ignore warnings and use with caution
#-ignorewarning
#-dontwarn


#保护 generics are not confused
-keepattributes Signature


# Reserved code line number when throwing an exception
-keepattributes SourceFile,LineNumberTable


#四大组件
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Appliction
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends android.view.View
-keep public class com.android.vending.licensing.ILicensingService


#Annotation in protected code is not confused
-keepattributes *Annotation*


# Reserved all classes under support and their inner classes
-keep class android.support.** {*;}


#留继承的
-keep public class * extends android.support.v4.**
-keep public class * extends android.support.v7.**
-keep public class * extends android.support.annotation.**


# Reserved resources under R
-keep class **.R$* {*;}


# Keep local native methods not to be confused
-keepclasseswithmembernames class * {
    native <methods>;
}


# Keep enumeration classes not to be confused
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}


# The method parameter reserved in the Activity is the view method.
# In this way, the onClick we wrote in the layout will not be affected.
-keepclassmembers class * extends android.app.Activity{
    public void *(android.view.View);
}


# Keep our custom controls (inherited from View) not to be confused
-keep public class * extends android.view.View{
    *** get*();
    void set*(***);
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}


# Keep Parcelable serialization classes not to be confused
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}


# Reserved Serializable serialized classes are not confused
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    !private <fields>;
    !private <methods>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}


# webView处理, the project is not used to ignore the webView
-keepclassmembers class fqcn.of.javascript.interface.for.webview {
    public *;
}
-keepclassmembers class * extends android.webkit.webViewClient {
    public void *(android.webkit.WebView, java.lang.String, android.graphics.Bitmap);
    public boolean *(android.webkit.WebView, java.lang.String);
}
-keepclassmembers class * extends android.webkit.webViewClient {
    public void *(android.webkit.webView, java.lang.String);
}


# Remove the Log class to print the code of each level of the log, when the official package can be used as a forbidden log, here can be used as a function prohibiting log printing
# Remember that proguard-android.txt must not add -dontoptimize to work.
# Another implementation is controlled by the variables of BuildConfig.DEBUG
#-assumenosideeffects class android.util.Log {
#    public static int v(...);
#    public static int i(...);
#    public static int w(...);
#    public static int d(...);
#    public static int e(...);
#}


# Keep test related code
-dontnote junit.framework.**
-dontnote junit.runner.**
#-dontwarn android.test.**
#-dontwarn android.support.test.**
#-dontwarn org.junit.**


-dontnote android.net.http.*
-dontnote org.apache.commons.codec.**
-dontnote org.apache.http.**


#-dontwarn javax.servlet.**
#-dontwarn org.joda.time.**
#-dontwarn org.w3c.dom.**