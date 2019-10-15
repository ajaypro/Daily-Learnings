### General

* JVM uses JIT compiler to convert bytecode to machine code so that can be used in different platforms. 
* DVM(Dalvik VM) - uses same JIT compiler for android but was lagging behind due to its runtime compilation of the application which makes
   app launch delay. 
* ART(Android Runtime) - uses AOT (ahead of times) which compiles when app is getting installed which is been converted into binaries 
   specific to your devices, execution is faster 
   * But AOT has issues such as since it takes time to convert data to binaries so initial runtime will be larger.
   * From nought android uses both JIT and AOT so that JIT helps in compiling at runtime and AOT caches the data and flows easily.
   * The main difference was that ART wasn’t running Interpreter/JIT on run time. It executed the precompiled code from an .oat binary instead resulting in much better and faster runtime. To compile code into an .oat binary, ART used the AOT Compiler.
   * Storage space: the entire .dex file was compiled into an .oat. Even parts that were rarely used or not used at all by a user (for example, the app settings that a user set once and never returned to again, or the login screen). So basically, we were wasting space on the disk, which was a problem for low-end devices with limited storage.
* When you get an app from the Play store, you download an .apk file with all the resources (images, icons, layouts) and compiled Java code .dex and install the app on your device. By tapping on the app icon, you start a new Dalvik process — .dex code is loaded and interpreted by the Interpreter or compiled by JIT in run time — and finally you see the app screen on your device.

### Blog

* [android compiler](https://proandroiddev.com/android-cpu-compilers-d8-r8-a3aa2bfbc109)
