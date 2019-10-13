### General

* JVM uses JIT compiler to convert bytecode to machine code so that can be used in different platforms. 
* DVM(Dalvik VM) - uses same JIT compiler for android but was lagging behind due to its runtime compilation of the application which makes
   app launch delay. 
* ART(Android Runtime) - uses AOT (ahead of times) which compiles when app is getting installed which is been converted into binaries 
   specific to your devices, execution is faster 
   * But AOT has issues such as since it takes time to convert data to binaries so initial runtime will be larger.
   * From nought android uses both JIT and AOT so that JIT helps in compiling at runtime and AOT caches the data and flows easily. 
