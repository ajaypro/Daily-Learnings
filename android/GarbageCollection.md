##GarbageColleciton 

* Generally GC will be called when onDestory() and finish() methods
  are called in android. We can call finish anywhere in the application
  in case we want to destroy the instance. 
* Android internally calls `System.exit()` to end the process
 on which the application is running.  

###minor
 * clears unreferenced objects 
 * runs from 2-5 ms 
 * does not crash the application
   
###large
 * interuppt the heap memory for allocation of objects
 * cleans up memory for new objects
 * runs 50 - 100ms
 