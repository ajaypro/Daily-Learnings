Basics
------

* Avoids object allocation as when used as functions to other functions as parameter, avoids creating a NEW call to a function and any
  higher order functions that creates a object allocation with memory allocation with runtime overhead.
* Because of INLINE keyword the compiler copies the content of higher order functions to calling site avoids creating new object
* Avoid using inline for functions that does not have another function as a parameter
* Avoid inlining for large function its allows the code grow a lot 
