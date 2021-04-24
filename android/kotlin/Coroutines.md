
## Coroutines

* Coroutines are defined in their own scopes and unlike thread they do not block
* `launch` - coroutine builder constructs coroutine and ready to go
* [Examples of coroutines with different uses cases, useful to learn from basics to advance](https://github.com/mitchtabian/Kotlin-Coroutine-Examples)
* [Very good kotlin coroutines repo with testcases and exceptions](https://github.com/MindorksOpenSource/Kotlin-Coroutines-Android-Examples)
* We can start one coroutine in one thread and can switch to another thread to update or do someother activity 


```
  
 button.setOnClickListener{
 // Started in IO thread 
 CoroutineScope(IO).lauch{
    apiRequest()
    }
  
  suspend fun setTextOnMainthread(str: String){
  // Switcing to main thread context from IO thread
  withContext(Main){
   textView.setText = str
  }
  }
 suspend fun apiRequest1(){
 val result1 = getApiResult1()
 setTextOnMainthread(result1)
 
 // runs the second api request since its in same job its runs one after the other
 
 val result2 = getApiResult2(result1)
 setTextOnMainthread(result2)
 }
 
 suspend fun getApiResult(): String{
  delay(1000)
  return RESULT1
 }
 
 suspend fun getApiResult2(): String{
  delay(1000)
  return RESULT2
 }
 

```
* Coroutines have a default job for each scope defined.
* Many coroutines can run in a single thread at once.
* Kotlin has a method Deferred.await() that is used to wait for the result from a coroutine started with the async builder.
* A scope controls the lifetime of coroutines through its job. When you cancel the job of a scope, it cancels all coroutines started in    that scope
* you can use a scope to cancel all running coroutines, the co-routine of particular scope
* If the main thread finishes the work, though the coroutine is running in different thread will be cancelled because the main thread of OS takes care of presenting the UI to user

* A coroutine can switch dispatchers any time after it's started. e.g a coroutine can start on the main dispatcher then use another dispatcher to parse a large JSON result off the main thread.

 `CoroutineScope(Dispatchers.Main + viewModelJob)`
 
* A CoroutineScope can take a CoroutineContext as a parameter, above it takes `main` as threading policy and the job `viewModelJob`
* Scopes created with the `CoroutineScope` constructor add an implicit job, which you can cancel using   `uiScope.coroutineContext.cancel()`.

Under the hood
--------------

* Coroutines create optimized callbacks it has a `interface Continution<T>`
```
suspend fun loginUser(login: String, password: String): User{
val user = userService.login(login, password)
val userDb = userDb.save(user)
return userDb
}
```
* The above suspend kotlin compiler will change it to
```
fun loginUser(login: String, password: String, continution: Continution<Any?>){
val user = userService.login(login, password)
val userDb = userDb.save(user)
continution.resume(user)
}
```
* Here the suspend keyword is changed into continuation and the `continution.resume(user)` is result that will be communicated as 
 a callback to coroutine .
* Since the compiler generates state machine, the suspend function won't stop until it completes the work and also the suspend function
 will continue without blocking the thread because the everything that needs to resume its in continuation object thats passed around.


To use coroutines we need three things: Job, Dispatcher, Scope

## Job
* Basically, a job is anything that can be canceled. Every coroutine has a job, and you can use the job to cancel the coroutine. Jobs   can be arranged into parent-child hierarchies. Canceling a parent job immediately cancels all the job's children, which is a lot more convenient than canceling each coroutine manually.

* We can decide to complete the job by calling `job.complete()` not the coroutine or `job.completeExceptionally()` if there is 
  exception
* using `job.invokeOnCompletion()` is used for informing the user if something goes wrong 
* `CoroutineScope(IO + job).launch{ } job.cancel` - this only cancels particular job, not the coroutine context
* To update anything on mainthread toast, updateing textview use globalscope

 ```
  fun updateTextView(){
  GlobalScope.launch(Main){
     textView.setText("Updating in main thread using coroutine")
  ```
* If a job is cancelled only a new job is started, we cannot resuse the old job  

## Jobjoin - 
*

``` 

runBlocking {
                Log.i(TAG, "runBlocking0 ${Thread.currentThread().name}")

                val job = launch(Dispatchers.IO){

                    Log.i(TAG, "runBlocking1 ${Thread.currentThread().name}")
                    delay(3000L)
                }
                job.join()

                launch(Dispatchers.IO){

                    Log.i(TAG, "runBlocking2 ${Thread.currentThread().name}")
                    delay(3000L)
                }
            }
	 
 ```
	 
* `job.join()` is a function which will wait until the current job is completed and then start ther new job in the above code first launch block will complete and 
  then second launch block will continue. if no `job.join()` is given both launch block will be executed simultaneously.
	    

## Dispatcher 
* The dispatcher sends off coroutines to run on various threads. For example, Dispatcher.Main runs tasks on the main thread, and Dispatcher.IO offloads blocking I/O tasks to a shared pool of threads.

## Scope 
* Default - for heavy computation, working with huge collections 
* IO - for db and network calls 
* Main - to interact with ui thread 
* A coroutine's scope defines the context in which the coroutine runs. A scope combines information about a coroutine's job and dispatcher. Scopes keep track of coroutines. When you launch a coroutine, it's "in a scope," which means that you've indicated which scope will keep track of the coroutine.

* The library adds a `viewModelScope` as an extension function of the `ViewModel` class. This scope is bound to `Dispatchers.Main` and        will automatically be cancelled when the `ViewModel` is cleared.

* They make use of suspend functions to perform heavy tasks which are defined outside coroutines but called in their scope.

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

## Mutex

* Helps in accessing a shared resources without being altered when accessed by multiple coroutines at sametime. 
* The mutex is Kotlin’s mechanism to help us control access to shared resources via a suspending function. The mutex provides us with mutual exclusion: it allows a single coroutine to access a shared resource while any other coroutines attempting to access that same shared resource will suspend execution. The mutex helps to keep things working smoothly and deliver expected outcomes in shared resource situations.
* [good mutex blog](https://medium.com/mobile-app-development-publication/mutex-for-coroutines-5f4a4ca60763)

## Blogs

* (coroutines over Rxjava) [https://proandroiddev.com/forget-rxjava-kotlin-coroutines-are-all-you-need-part-1-2-4f62ecc4f99b]
* (comparision)[https://medium.com/capital-one-tech/coroutines-and-rxjava-an-asynchronicity-comparison-part-2-cancelling-execution-199485cdf068]
* (coroutines over Rxjava - 2)[https://proandroiddev.com/forget-rxjava-kotlin-coroutines-are-all-you-need-d4dbdb509708]
* (Coroutine execution in main thread)[https://medium.com/@trionkidnapper/launching-a-kotlin-coroutine-for-immediate-execution-on-the-main-thread-8555e701163b]
* [good blogs for basics quick understanding](https://blog.mindorks.com/mastering-kotlin-coroutines-in-android-step-by-step-guide)
* [examples with depth](https://medium.com/androidiots/androidiots-podscast-7-unmasking-kotlin-coroutines-ce2711269d3b)
*  [google blog series very good ](https://medium.com/androiddevelopers/coroutines-on-android-part-ii-getting-started-3bff117176dd)
* [async - coroutine](https://proandroiddev.com/async-operations-with-kotlin-coroutines-part-1-c51cc581ad33)

## Job

* Completable job has more features than `Job` like 
   `job.complete()` just completes the job
   `job.completeExecptionally()` completes job with execption to throw exceptions, error message.
* `CompleteableJob` extends `Job` class
* Job that can be completed manually by you (you have more control) e.g downloading a file and then cancelling it.
* Can be used to launch coroutines in their own independent context. 
* Ability to very easily cancel jobs and create new ones
* If a job is cancelled we cannot reuse the job, rather we can recreate the job. 

## Exception Hanlding

* for launch -> the exceptions are thrown,
* aysnc -> hold exceptions until await is called 
* Normally exceptions are handled in scopes such as coroutinescope, supervisorscope 
* Coroutinescope -> If there are series of network call and if any of network call fails the coroutine cancels everything
* SupervisorScope -> won't cancel other children network calls if any of the network call fails, returns a empty list and continues with other calls.

## How to cancel a coroutine

* e.g 
```
scope.launch(Dispatchers.IO){
   for(name in files){ // looping
   yield()/ ensureActive() // check for whether coroutine is active as it would be doing heavy computation it won't listen to cancellation so we need to check
    this method 
      readFile(name) // read file 
}

```

## Using single job and cancelling

* Launching coroutine IO with job helps us to deal only with that job alone, the coroutine will create and run the job within its own 
  individual context. This will not cancel other jobs running in the same context
```
CoroutineScope(IO + job).launch{ 
}

job.cancel // will cancel only this job alone, other jobs running in IO scope won't get cancelled
```

* In this scenario if we cancel the coroutine, all the jobs within the IO scope will be cancelled not in the above case
```
val scope = CoroutineScope(IO).launch{ 
....
}

CoroutineScope(IO).launch{ 
....
}
scope.cancel()
```

## About Cancellation 

* When you cancel coroutinescope all children in scope will also be cancelled. 

* `suspendCoroutine` is a good choice when you don't need to support cancellation. Typically, however, cancellation is a concern and you   can use `suspendCancellableCoroutine` to propagate cancellation to libraries that support cancellation to a callback based API. 

* Coroutines package has cancellable in their package, all suspending fucntions in `kotlinx.coroutines` are cancellable. So these functions will check if the coroutine are been cancelled if not they cancel it. 
e.g 

```
suspend fun primeNumber(){
  while(true){
  //compute
  delay(1000)
  }
  }
  
```
* If there aren't any cancellable functions then we can use `isActive` in coroutine to check is alive


## Test Setup

* `kotlinx-coroutines-test`provides many utilities to simplify testing coroutines on Android

    Auto-advance of time for regular suspend functions
    Explicitly control time for testing multiple coroutines
    Eagerly execute the bodies of launch or async code blocks
    Pause, manually advance, and restart the execution of coroutines in a test
    Report uncaught exceptions as test failures

* `InstantTaskExecutorRule` is a JUnit rule that configures LiveData to immediately post to the main thread while a test is run
* `suspendCoroutine` that's used to convert callback-based APIs to suspend functions.
* `suspendCoroutine` will give you a `continuation` object that you can use to resume the coroutine.
* The continuation that suspendCoroutine provides has two functions: resume and resumeWithException. Calling either function will cause   suspendCoroutine to resume immediately.

## Testing Co-routines

## UseCase 1
 
* Using `runBLocking` function to be used when we are not using coroutine such as 
  e.g 
  
  ```
      suspend fun loadData() {
        val data = networkData() // this is not calling a coroutine so we can use runBlocking to test it
         } 
	 
	Testing 
	
	fun `test_load_data`() = runBlocking {
	val viewmodel = ViewModel()
	viewmodel.loadData()
	}
 
* runBlocking is a coroutine library and it starts a coroutine and blocks the main thread until everything finishes

## UseCase 2

* Using dispatcher while running coroutine follow this video from 20:20 sec (https://www.youtube.com/watch?v=ZTDXo0-SKuU&t=16s)[Very good coroutine with test case video]
	
* The test runner doesn't know anything about coroutines so we can't make this test a suspend function. We could launch a coroutine using a `CoroutineScope` like in a ViewModel, however tests need to run coroutines to completion before they return. Once a test function returns, the test is over. Coroutines started with `launch` are asynchronous code, which will complete at some point in the future. Therefore to test that asynchronous code, you need some way to tell the test to wait until your coroutine completes. Since launch is a non-blocking call, that means it returns right away and can continue to run a coroutine after the function returns, it can't be used in tests.

* This test will always fail. The call to launch will return immediately and end the test case. The exception from `await()` may happen before or after the test ends, but the exception will not be thrown in the test call stack. It will instead be thrown into scope's uncaught exception handler.

* Kotlin has the `runBlocking` function that blocks while it calls suspend functions. Inside the runBlocking block what ever executes it block the main thread. 
`runBlocking` used inwriting testcases for testing co-routines, also used to learn details of how co-routines work 
In case if we want to use suspend functions without co-routine then we use runblocking 
[reference link - good explaantion](https://www.youtube.com/watch?v=k9yisEEPC8g)
You can think of it as a way to convert suspend functions into normal function calls.

* Since runBlocking runs coroutines just like a normal function, it will also throw exceptions just like a normal function

* The function runBlocking will always block the caller, just like a regular function call. The coroutine will run synchronously on the same thread. You should avoid runBlocking in your application code and prefer launch which returns immediately.

* `runBlocking` should only be used from APIs that expect blocking calls like tests.

## AndroidDevSummit

### Livedata with coroutines and flow

* To do something when activity or fragment starts we can use `lifecycleScope.launch` and `lifecycleScope.launchWhenResume` for `onResume()` this runs the `suspend block` only when the lifecycle state in started or greater(resume state), so if the activity goes to `onStop()` it stops execution and returns to resume when the activity resumes.

* *LiveData-Coroutine-Builder*  - It is a coroutine block for livedata starts executing when livedata is observed and canceled by data not used anymore and inside that we can emit results 

```
class ViewModel{
  val result = liveData{
  emit(computation)
  }
  }
```
* *User selecting an item to fetch details* 

```
private val itemId = MutableLiveData<String>()
val result = itemId.switchMap{
 livedata{ emit(fetch(it))}
 }

```

* we can also use scopes in livedata coroutine scope such as 

`livedata(Dispatchers.IO){}`


## Working of `launch` and `runBlocking` 

* A suspend lambda allows you to call suspend functions. That's how Kotlin implements the coroutine builders `launch` and `runBlocking`

## NEED TO WORK 

* DOUBT: launch returns immediately work on it

 
