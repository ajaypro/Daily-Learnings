# General

* To schedule tasks using job scheduler you need to create a `JobInfo()` and give a jobnumber and jobservice.
* `JobService` extends JobService class and overriding few methods. 
* `onStartJob()` - will start the job once the conditions are met which are given like network connectvitiy, battery strength and
the job scheduler runs on main thread. 
* We need to defer it to another thread or coroutines for longer operations and `return true` if the job is finished running else 
 `return false` else still running. 
* `onStopJob()` is called by the system when the job gets cancelled due to none of the conditions met use this for safety 
checks and `return true` if you want system to continue run the jobs.
* `JobFinished()` need to called to inform that job is been completed i.e when onStartJob returns true, so that the system releases
wakelocks.  `JobFininshed(job, boolean)` job - indicating which job and boolean tells whether to continue the job 
* Mention jobservice in manifest file and add permission so that jobscheduler will call your jobs that can access `JobService`
* Finally you can create `JobScheduler` object and schedule the job. 

Code Snippet

`JobScheduler jobscheduler = (JobScheduler)
getSystemService(Context.JOB_SCHEDULER_SERVICE);
jobscheduler.schedule(new JobInfo.Builder (LOAD_ARTWORK_JOB_ID,
  new ComponentName(this. DownloadArtworkJobService.class))
            .setRequiredNetworkType(JobInfo.NETWORK_TYPE_ANY)
            .build())`
            
## Blogs 

* [https://medium.com/google-developers/scheduling-jobs-like-a-pro-with-jobscheduler-286ef8510129]
* (app to muzei)[https://github.com/romannurik/muzei]
