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
  * Once the `workRequest` is build then we get instance of workmanager and enqueue the workRequest.
  * Instead of calling `workManager.enqueue()`, call `workManager.beginWith()`. This returns a `WorkContinuation`, 
   which defines a chain of WorkRequests. You can add to this chain of work requests by calling `then()` method, for example, 
   if you have three WorkRequest objects, workA, workB, and workC
   
   ```
      val continuation = workManager.beginWith(workA)

       continuation.then(workB) // FYI, then() returns a new WorkContinuation instance
        .then(workC)
        .enqueue() // Enqueues the WorkContinuation which is a chain of work 
        
   ```
   * *WorkInfo* contains the status of workrequest you can use `LiveData` that holds `WorkInfo` object to observe the status of each 
     work request 
   
   * *How work request runs :* 
    * Initially the requests are persisted in the workmanagerdb and all the status about the workRequest will be stored in here. 
    * if in API23+ we send request to `jobScheduler`
    * if in API22- and has Google play services we send request to `GcmNetworkManager` if not `alarmManager`
    * Since the `jobscheduler`, `GcmNetworkManager` and `alarmManager` reside outside of app they will wake up the app when its not
      running, while also keep track of constraints defined.
    * `GreedyScheduler` is part of the app and will be made to run the request when the app is awake, this is much faster than all the
      above.
    
   * *When work won't run*
   * when constraint not met 
   * in Doze mode, jobs can be delayed in doze mode to preserve battery
   * Battery saver mode bg work won't run
   * If any prerequsities are not fulfilled then parent job and its child jobs keeps failing
   * Workermanager is limited by `ThreadPool` size so max jobs would be 2-4, beyond that it fails
   * If app is doing too much work, jobs will fail to run.
   * force stop will wipe out all jobs and alarms 
   
   * *Work running often*
   *  starting workmanager and enqueueing in onCreate(), instead use `.enqueueUniqueWorkRequest()` and KEEP the existing work which is
      started
      
   ## Initialization
   
   * *AutoInitilization:* Android provides workmanager as content provider which gets intilized before the app is initiazed but this 
     creates a overhead for the app to start
   * *On-demand initialization* a.k.a lazy initialization, we disable autoinitilization and will check if its workmanager is initialized
      else we will initialize it.
       *  and cons so pros are obvious for on-demand initialization it can lead to a more performant app startup that's because we don't    actually block your application on page for initializing work manager we initialize it lazily it can also work around a lot of device.
   * Application : Configuration.Provider to get initial configuration of work manager if not present it uses default configuration.
   
   ## Testing 
   
   * We use TestListenableWorkerBuilder to create a worker class using which we test the actual worker class 
    
     
     ### Blogs
     
     * [Basics of WorkManager](https://medium.com/mindorks/work-manager-in-android-9cdb66c9a1df)
     * [Good location tracking example ](https://medium.com/google-developer-experts/services-the-life-with-without-and-worker-6933111d62a6)
   
