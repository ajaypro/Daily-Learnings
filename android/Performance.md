## Myths

* *Code Patterns :*
  
 * Accessing getters and setters are expensive
    * Not true as ART inlines this as it is accessing compile time code 
 * Lambdas slower than inner class
    * Internally its convereted into anonymous classes and better way to write concise, better code. 
 * Object allocation and garbage collection are slower in android
    * Android uses state-of-art garbage collection and object allocation
 * Standard allocation of objects are costlier than object pool- not true it depends. 
    * object pool - has risk of keeping objects alive more than needed.
 * Profiling in debuggable mode is fine 
 * Multidex files does not impact size and memory 
    * However it does affect as every split dex file because it will have duplicates of other dex files in each package
    * Always measure app if it multidex with tools such as R8/D8 so that it will avoid common pitfalls 
 * dead code does not get executed
    * Most apps have 86% of non-profiled code(dead) than profiled code
       * *DeadCode* 
       * backward compatibility code 
       * code for lower end devices( that doesn't get executed in higher end devices)
       * unexpected error handling paths 
       * Uncessary code - use R8 to minify code
    
   
