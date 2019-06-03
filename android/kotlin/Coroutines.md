
## Coroutines

* coroutines are defined in their own scopes and unlike thread they do not block
* they makr use of suspend functions to perform heavy tasks which are defined outside coroutines but called in their scope.
   ```
   suspend fun callDb(){
   ....
   }
   ```
* suspend function does not block the thread, it suspends execution until result is ready and then resumes
* They perform sequential operations when compared to callbacks which relies on result and trigger the next operation 
   of callback 
* Due to sequential operation of coroutines chaining function are easy, rather than going for multiple callbacks. Such as one function making 
 a network request another updating the ui 
 
```
@WorkerThread
suspend fun makeNetworkRequest() {
    // fetch and updateUI are suspend functions
    val fetch = fetch()
    val updateUI = updateUI(Dispatchers.main)   
}

suspend function fetch(): Fetch{...}
suspend function updateUI(): updateUI {...}
```

* Kotlin has a method Deferred.await() that is used to wait for the result from a coroutine started with the async builder.

* Consider this example code 

  ```
  fun getrefreshStatus(/* ... */) {
   val result = network.fetchNewStatus()
    result.addOnResultListener { result ->
       // callback called when network request completes or errors
       when (result) {
           is NetworkSuccess<String> -> {
               // process successful result
           }
           is NetworkError -> {
               // process network error
           }
       }
   }
   }
   ```
* Now `fetchNewStatus()` will be long running task and get the result which exposes a callback listener which saves data in db based on result's success
or error
* Now we need to rewrite `fetchNewStatus`  as a suspend function so that `getrefreshStatus()`  can written as coroutine
* Kotlin provides `suspendCoroutine` will immediately suspend the current coroutine. suspendCoroutine will give you a `continuation` object 
that you can use to `resume` the coroutine. 
A continuation does what it sounds like: it holds all the context needed to continue, or resume, a suspended coroutine.

* The continuation that suspendCoroutine provides has two functions: `resume` and `resumeWithException`. 
 Calling either function will cause suspendCoroutine to resume immediately.    
 
* we write a extension function of NetworkCall class and make it suspend function which returns `suspendCoroutine` that gives `continuation` object 
which returns result of this callback using `resume` and `resumeWithException` 

Code sample 

```
suspend fun <T>NetworkCall<T>.await(): T {

    return suspendCoroutine {continuation ->
        addOnResultListener { value ->
            when(value){
                is NetworkSuccess<T> -> continuation.resume(value.data)
                is NetworkError<T> -> continuation.resumeWithException(value.error)
            }
        }

    }
}
```

* Calling the suspend function await() in suspend function `getrefreshStatus()`
   ```
   suspend  fun getrefreshStatus() {

        try {
		 val result = network.fetchNewStatus().await()
		 } catch(error: NetworkException){
		   }
  }
  ```


* Replaced code of `getrefreshStatus()` after performing insert into db

```
suspend fun getrefreshStatus() {
   withContext(Dispatchers.IO) {
       try {
           val result = network.fetchNewStatus().await()
           titleDao.insertStatus(Status(result))
       } catch (error: NetworkException) {
           throw StatusRefreshError(error)
       }
   }
}
```

* In the above code we make a call to suspend function `fetchNewStatus` to get result since the await function returns the result for us we 
can use them in inserting into db which is run in separate thread due to the code `withContext(Dispatchers.IO)` Dispatchers.IO used for 
running heavy operations and once it completes the execution coroutine switches to run with the dispatcher specified previously.

* Below is the calling function existing code `refreshStatus` which passes a callback function to getrefreshStatus to display result in UI, this blocks 
the current thread till the callback comes with results  which we will be replacing it with coroutine scope that does not block

```
fun refreshStatus() {
   // pass a state listener as a lambda to refreshTitle
   repository.getRefreshStatus { state ->
       when (state) {
           is Loading -> _spinner.postValue(true)
           is Success -> _spinner.postValue(false)
           is Error -> {
               _spinner.postValue(false)
               _snackBar.postValue(state.error.message)
           }
       }
   }
}
```

* Replaced code after implementing co-routine scope, as we leverage `viewModelScope` offered by KTX, this takes the pain of clearing the `viewModelScope`

```
fun refreshStatus() {
        // pass a state listener as a lambda to refreshTitle

        viewModelScope.launch {
            try {
                repository.refreshStatus()
                _spinner.value = true
            } catch (error: StatusRefreshError) {
                _snackBar.value = error.message
            } finally {
                _spinner.value = false
            }

        }
}
```

* Uncaught exceptions in a coroutine scope are similar to uncaught exceptions in non-coroutine code. By default, they'll cancel the job that was passed 
to the scope and pass the exception to the uncaughtExceptionHandler
	

## About Cancellation 

* suspendCoroutine is a good choice when you don't need to support cancellation. Typically, however, cancellation is a concern and you can use 
 suspendCancellableCoroutine to propagate cancellation to libraries that support cancellation to a callback based API. 

* DOUBT: launch returns immediately work on it
 
