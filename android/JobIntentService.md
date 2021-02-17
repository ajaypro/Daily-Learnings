Basics
------

* lifecycle: `onCreate()`, `onHandleWork(Intent)`, `onDestroy()`, `onStopCurrentWork()`
* Don't have to handle wakelocks as jobintentservice itself will take of it. 
* `onStopCurrentWork()` will be executed when job scheduler stops the current job only in API 26 & above
  * when system is in high memory pressure
  * in doze mode
  * when jobs are cancelled as they have time limit only for 10 mins and then they wil defer
* Once jobs stops in `onStopCurrentWork()` we need to handle to stop the service in `onHandleWork` else system will kill it so call
  `isStopped()` to check for service is stopped and return. 
* In JobIntentService we dont have options give constraints like job scheudler we just call `enqueueWork(Intent)`
* Since Android Oreo (API 26), background services can’t keep running while the app itself is in the background. Instead, the system will kill them after around 1 minute or throw an IllegalStateException if we try to call startService from the background
