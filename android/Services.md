### blogs

* [Deep dive services basics](https://proandroiddev.com/deep-dive-into-android-services-4830b8c9a09)

## Basics

* Services can be started with `startForegroundService(Intent)`  which takes an explicit intent, with a persistant notification that 
  shows users the service is running in foreground
* Services lifecycle is 
     ```
     onCreate()
     onStart(Intent)
     onStartCommand(Intent, flags, startId)
     stopSelf
     onDestroy()
     ```
* When we start services  we can start a thread internally and calls `startService` and when `stopSelf` is called to stop service thread interally stops and `onDestory()` is called.
* Without attaching persistant notification we cannot make service as foreground service, important because a Started Service in the foreground is detached from the lifecycle of UI components (with the exception of the persistent notification)
* A Service can be called multiples times but its `onCreate()` will be called only once. 
* After starting a service with time if 5 seconds we need to call `startForegroundService(Intent)` to make service foreground service and for apps running in background it should run the service foreground.
 * Started Services can run in the foreground. Again, the term foreground doesn’t apply to whether the Service is running 
  on the main Thread or a Background Thread. It means that the Android system will give this service highest priority and 
  will try not to destroy it when t is running low on system resources.
  * Example of running foreground service is to better UX 
     music app playing or record music
     app that gets fine grained location
     
* **When system destroys service due to low memory issues the service behaves based on what its onStartCommand() returns**

                            
* **START_STICKY** - restarts automatically with null intent managed explicity, no need to remember state idle for music player which starts again but does not play old song. 

  **START_NON_STICKY**  does not restart automatically after selfstop but will be triggered  when a new intent comes periodically, e.g alarm service, polling to server.
  
  **START_REDELIVER_INTENT**   restart automatically and provides the same intent, e.g downloading files.
  
* **Check if service is running** - Get activitymanager and use getRunningServices to find the service.
* **Does service run even when activity is killed** - https://stackoverflow.com/questions/36101462/is-a-service-independent-of-the-activity-life-cycle
  
### Bound Services

* Bound Services allow a connection to be established between the Android component binding to the Service, this connection is an IBinder which allows methods to be called on the Service. 
* if the Service (Bound or Started) needs to send messages to the bound client or whatever component started a Service, it has to use something like `LocalBroadcastManager` when the the client and Service are local to one process.
  
  ```
  public class MyActivity extends Activity{
    void bind(){
        bindService(
                new MyIntentBuilder(this).build(),
                mServiceConnection,
                BIND_AUTO_CREATE);
    }
}
  ```
* BIND_AUTO_CREATE is that it calls `onCreate()` on the Bound Service if that hasn’t happened yet, at the time `bindService()` is called. 
  This essentially automatically creates the Bound Service upon the first client connecting to it.  
* IBinder object which it can then use to call methods on the Bound Service
* `mServiceConnection` is a ServiceConnection callback which the Bound Service will use to notify the client about the completion of the binding process. 
  It will let the client know as well if the Bound Service has disconnected.
* Binder is an Android base class that allows a remotable object to be created. It implements a lightweight RPC mechanism for 
  high performance in-process and cross-process calls (between clients and Bound Services).
* Binder  Service have to implement the `onBind()` method. This gets called only once, when the 
  very first client component connects to this Bound Service.
  
  ```
  public class MyService extends Service{
    public IBinder onBind(Intent intent){
        if (mBinder == null){
            mBinder = new MyBinder();
        }
        return mBinder;
    }
}
  
  ```
 * With a reference to this IBinder, the client can call public methods directly on the Bound Service object. 
      Note that these methods will execute on the thread of the client component that is calling these methods. 
      In the case of an Activity or Fragment, these methods will run on the main thread, so be careful of calling blocking methods 
      on the Bound Service and causing ANRs in your app.
 * To stop the service 
 
 ```
 public class MyActivity extends Activity{
    protected void onStop(){
        if (mServiceBound){
            unbindService(mServiceConnection);
            mServiceBound = false;
        }
    }
}
 ```
* In the bind service 
  ```
   public class MyService extends Service{
    public boolean onUnbind(Intent i){
        return false;
    }
}
  ```

