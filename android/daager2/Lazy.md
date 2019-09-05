# Usage 

* Using lazy to boost app startup time if we are having expensive objects. 
* just use keyword lazy in front of object while declaring it 
```
 @Inject
lateinit var heavyObject: Lazy<HeavyObject>
```
* Before using lazy if we check its implementation we would know that it uses DoubleCheck locking design pattern. 
* Dagger is injecting a lazy Provider (wrapped in a DoubleCheck) rather the object itself so we now have to use `get()` to access 
 the object which is not ideal and adds a bit more code in places where you didn’t need it before.
 * Lazy computes its value on the first call to get() and remembers that same value for all subsequent calls to `get()`
 
 ## DoubleCheck locking
 
 * the idea is to check the value twice, first without locking it and if the field is not initialized a second check where 
 we lock the field and initialize it, without doublecheck the chances of accessing the variable is higher since we would be 
 locking the field every single time we try to access it.
 
 ## Ref Links
 
 * [Lazy in kotlin](https://proandroiddev.com/deep-dive-into-dagger-lazy-7a5860cca7cc)
