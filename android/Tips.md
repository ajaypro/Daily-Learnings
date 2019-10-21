## This page is for general tips which I have come across or read through

* To get unique Device ID when you using telephony manager will be suitable only for smartphones as tablets do not have telephony services 
* Devices without telephony services like tablets must report a unique device ID that is available via android.os.Build.SERIAL
* We can get Android Id unique and constant throughout device lifecycle both for smartphones and tablets, 
  Settings.Secure.ANDROID_ID it’s a 64-bit number. 
* `String androidId = Settings.Secure.getString(getContentResolver(),
                     Settings.Secure.ANDROID_ID);`
* However, the value may change if a factory reset is performed on the device.
* Using UUID is best solution as it is unique for a installation, using this we can identify a user even if he changes different devices. 

[ref link:] (https://medium.com/@ssaurel/how-to-retrieve-an-unique-id-to-identify-android-devices-c40080e04fa4) 

* When using dagger2 to invoke `injectDependencies()` inside `onCreate()` before `super.onCreate()` or any other initialization, to get pass creating views and get dependencies. 

* Using !!(not-null assertion operator) `context!!.applicationContext` in fragment where we are trying to get `activityContext` in 
  fragment if we don't get its ok to throw error during compile time(fail-fast) 

## UI

* To build custom `BottomNagivationView` we can use this [library](https://github.com/armcha/Space-Navigation-View) 

   
  

