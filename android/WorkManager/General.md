## Basics

* WorkManager uses `Worker` class to perform work such as 
  * long running tasks with constraints based on 
      * battery charging
      * Network availability
      * Storage
      * CPU 
   * also it does takes care of threading, resources allocation, runs tasks even when app @background or closed, when system is 
      rebooted. 
   * WorkManager internally chooses between Jobscheduler or alarm manager with broadcast receiver based on api level to execute its tasks.
 * It uses `Worker` class and overrides `doWork()` where the acual tasks run, 
      * this method runs on bg thread and also runs for max of 10 mins, and does work synchrousnly which returns a `Result` object as 
         completed tasks. 
      * Once you return from this method, the Worker is considered to have finished what its doing and will be destroyed.
      * If you need to do your work asynchronously on a thread of your own choice
      
  * `WorkRequest` can be created using `OneTimeWorkRequestBuilder` or `PeriodicWorkRequestBuilder` for parallel work. Data object can
    be passed into requestBuilder using `setInputData(Data)` and `enqueue()` is called. 
  * Instead of calling `workManager.enqueue()`, call `workManager.beginWith()`. This returns a `WorkContinuation`, 
   which defines a chain of WorkRequests. You can add to this chain of work requests by calling `then()` method, for example, 
   if you have three WorkRequest objects, workA, workB, and workC
   
   ```
      val continuation = workManager.beginWith(workA)

       continuation.then(workB) // FYI, then() returns a new WorkContinuation instance
        .then(workC)
        .enqueue() // Enqueues the WorkContinuation which is a chain of work 
        
   ```
   * **WorkInfo** contains the status of workrequest you can use `LiveData` that holds `WorkInfo` object to observe the status of each 
     work request 
     
     ### Blogs
     
     * [Basics of WorkManager](https://medium.com/mindorks/work-manager-in-android-9cdb66c9a1df)
   
