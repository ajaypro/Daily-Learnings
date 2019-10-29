### General

* For android the instances and references variables gets stored in registers unlike stack in java's JVM. 
* When an object is created with new keyword its created in heap memory of RAM and its reference variables will hold the address of this 
   heap memory. 
   `Bus bus = new Bus`
   `new Bus` - gets stored in heap memory, `bus` - reference variables hold the address of `new Bus` object in heap memory. 
* Heaps of different types the system allocates small heap when starting an app and increases in size as app grows. But allocating
  larger heap is only for CPU intensive apps such as image optimizations apps which needs more CPU. 
* GC has small Gc's and large Gc's
   * small Gc run for 2-4 ms and clears data objects but does not crash app
   * large Gc run for 50 - 100ms and Stop the app and freezes the UI which will have lag, so if we are having large objects or large 
      number of object creation then often large GC runs.
* Stack memory will store using nodes each node can store primitives and object references and when another method calls with arguments
   of same primitive variables it will only store copy of primitive variable and each thread will have a stack memory on its own.
* When a thread makes methods calls one after other, after which if it does not have memory to call 4th method then its
   throws stackoverflow error and this is faster then heap memory as there is no GC call.
   
 ### Blogs
 
 * [Understanding memory usage](https://blog.mindorks.com/understanding-memory-usage-in-android)
 
