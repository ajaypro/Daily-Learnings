# Baidu map (jar package replaced with its own version, remember to match the signature)
#-libraryjars libs/baidumapapi_v2_1_3.jar
-keep class com.baidu.** {*;}
-keep class vi.com.** {*;}
-keep class com.sinovoice.** {*;}
-keep class pvi.com.** {*;}
# - dontwarn com.baidu . **
# - dontwarn vi.com . **
# - dontwarn pvi.com . **


#Baidu push broadcast
-libraryjars libs/pushservice-VERSION.jar
- dontwarn com.baidu . **
-keep class com.baidu.**{*; }


# Bugly
#-dontwarn com.tencent.bugly.**
-keep class com.tencent.bugly.** {*;}


# ButterKnife
-keep class butterknife.** { *; }
#-dontwarn butterknife.internal.**
-keep class **$$ViewBinder { *; }
-keepclasseswithmembernames class * {
    @butterknife.* <fields>;
}
-keepclasseswithmembernames class * {
    @butterknife.* <methods>;
}


# EventBus
-keepattributes *Annotation*
-keepclassmembers class ** {
    @org.greenrobot.eventbus.Subscribe <methods>;
}
-keep enum org.greenrobot.eventbus.ThreadMode { *; }


# Facebook
-keep class com.facebook.** {*;}
-keep interface com.facebook.** {*;}
-keep enum com.facebook.** {*;}
- dontnote com.facebook . **


# FastJson
# - dontwarn com.alibaba.fastjson . **
-keep class com.alibaba.fastjson.** { *; }
-keepattributes Signature
-keepattributes *Annotation*


# Fresco
-keep class com.facebook.fresco.** {*;}
-keep interface com.facebook.fresco.** {*;}
-keep enum com.facebook.fresco.** {*;}


# Glide
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public enum com.bumptech.glide.load.resource.bitmap.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}
- dontnote com.bumptech.glide . **


# Gson
-keep public class com.google.gson.**
-keep public class com.google.gson.** {public private protected *;}
- dontnote com.google.gson . **
-keepattributes Signature
-keepattributes *Annotation*

* when module1 and module2 are Dynamic Feature Modules with databinding enabled
-keep class com.example.module1.DataBinderMapperImpl { *; } 
-keep class com.example.module2.DataBinderMapperImpl { *; } 


# Jackson
#-dontwarn org.codehaus.jackson.**
#-dontwarn com.fasterxml.jackson.databind.**
-keep class org.codehaus.jackson.** { *;}
-keep class com.fasterxml.jackson.** { *; }


# OkHttp3
#-dontwarn com.squareup.okhttp3.**
-keep class com.squareup.okhttp3.** { *;}
# - dontwarn okio . **
#-dontwarn okhttp3.**
- dontnote okhttp3 . **


# Okio
#-dontwarn com.squareup.**
# - dontwarn okio . **
- dontnote okio . **
-keep public class org.codehaus.* { *; }
-keep public class java.nio.* { *; }
-dontnote java.nio.**


# OrmLite
-keepattributes *DatabaseField*
-keepattributes *DatabaseTable*
-keepattributes *SerializedName*
-keep class com.j256.**
-keepclassmembers class com.j256.** { *; }
-keep enum com.j256.**
-keepclassmembers enum com.j256.** { *; }
-keep interface com.j256.**
-keepclassmembers interface com.j256.** { *; }


# Realm
-keep class io.realm.annotations.RealmModule
-keep @io.realm.annotations.RealmModule class *
-keep class io.realm.internal.Keep
-keep @io.realm.internal.Keep class * { *; }
#-dontwarn javax.**
#-dontwarn io.realm.**
-dontnote io.realm.**


# Retrofit
#-dontwarn retrofit2.**
-keep class retrofit2.** { *; }
-keepattributes Signature
-keepattributes Exceptions


# RxJava RxAndroid
#-dontwarn sun.misc.**
-keepclassmembers class rx.internal.util.unsafe.*ArrayQueue*Field* {
    long producerIndex;
    long consumerIndex;
}
-keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueProducerNodeRef {
    rx.internal.util.atomic.LinkedQueueNode producerNode;
}
-keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueConsumerNodeRef {
    rx.internal.util.atomic.LinkedQueueNode consumerNode;
}


#微信支付
#-dontwarn com.tencent.mm.**
#-dontwarn com.tencent.wxop.stat.**
-keep class com.tencent.mm.** {*;}
-keep class com.tencent.wxop.stat.**{*;}


# Sina Weibo
-keep class com.sina.weibo.sdk.* { *; }
-keep class android.support.v4.* { *; }
-keep class com.tencent.* { *; }
-keep class com.baidu.* { *; }
-keep class lombok.ast.ecj.* { *; }
#-dontwarn android.support.v4.**
#-dontwarn com.tencent.**s
# - dontwarn com.baidu . **


#讯飞语音
# - dontwarn com.iflytek . **
-keep class com.iflytek.** {*;}


#银联
# - dontwarn com.iflytek . **
-keep class com.iflytek.** {*;}


#友盟统计分析
-keepclassmembers class * { public <init>(org.json.JSONObject); }
-keepclassmembers enum com.umeng.analytics.** {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}


#友盟Automatic update
-keepclassmembers class * { public <init>(org.json.JSONObject); }
-keep public class cn.irains.parking.cloud.pub.R$*{ public static final int *; }
-keep public class * extends com.umeng.**
-keep class com.umeng.** { *; }


# Alipay wallet
#-dontwarn com.alipay.**
#-dontwarn HttpUtils.HttpFetcher
# - dontwarn com.ta.utdid2 . **
#-dontwarn com.ut.device.**
-keep class com.alipay.android.app.IAlixPay{*;}
-keep class com.alipay.android.app.IAlixPay$Stub{*;}
-keep class com.alipay.android.app.IRemoteServiceCallback{*;}
-keep class com.alipay.android.app.IRemoteServiceCallback$Stub{*;}
-keep class com.alipay.sdk.app.PayTask{ public *;}
-keep class com.alipay.sdk.app.AuthTask{ public *;}
-keep class com.alipay.mobilesecuritysdk.*
-keep class com.ut.*


# fabric
-keep class io.fabric.sdk.android.** { *; }
-keep interface io.fabric.sdk.android.** { *; }
-keep class io.fabric.** { *; }
-keep interface io.fabric.** { *; }
-dontnote io.fabric.sdk.**


# crashlytics
-keep class com.crashlytics.** { *; }
-keep interface com.crashlytics.** { *; }
- dontnote com.crashlytics . **


# goa
-keep class net.ossrs.yasea.**{*;}
-keep class net.ossrs.yasea.SrsEncoder{*;}
-dontnote net.ossrs.yasea.**


# netty
#-dontwarn org.jboss.netty.**
-keep class java.util.concurrent.atomic.AtomicReferenceFieldUpdater {*;}
-keep class java.util.concurrent.atomic.AtomicReferenceFieldUpdaterImpl{*;}
-keep class org.jboss.netty.channel.DefaultChannelPipeline{volatile <fields>;}
-keep class org.jboss.netty.util.internal.QueueFactory{static <fields>;}
-keepclassmembernames class org.jboss.netty.util.internal.**{*;}
-dontnote org.jboss.netty.**


# kotlin
-dontnote kotlin.**


# apache
-dontnote org.apache.**
-keep class org.apache.commons.logging.* {*;}


# zxing
-dontnote com.google.zxing.**


# zxing-android-embedded
- dontnote com.journeyapps.barcodescanner . **


# loadingView
-dontnote com.ldoublem.loadingviewlib.**


# expandableLayout
-dontnote net.cachapa.expandablelayout.**


# arxingcore
-keep class org.arxing.arxingcore.view.** {*;}
-dontnote org.arxing.arxingcore.**


# others
-dontnote com.google.android.gms.**
-dontnote android.arch.**
-dontnote com.github.**
- dontnote com.googlecode . **
