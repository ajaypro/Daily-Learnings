Basics
------

## FusedLocationProvider

* Does not directly get values using the device rather provdes values that are cached from other applications if not, then access for the location.
* Ask for permissions before fetching ACCESS_FINE_LOCATION
* `fusedlocationprovider.requestlocationupdates(locationrequest,locationCallback,looper.mainLooper())` runs in the bg thread

## To get frequent location updates from device 

* Check for device settings where location is enabled and then
* create location request with the required interval
* Use fusedlocationprovider to get location updates
* Will get locationresult(list) in locationCallback `onLocationResult()`
* youtube video  - https://www.youtube.com/watch?v=4eWoXPSpA5Y
