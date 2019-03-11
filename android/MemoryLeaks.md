# Memory Leaks

[memory analysis android](http://android-developers.blogspot.in/2011/03/memory-analysis-for-android.html)

    1. Static Activity - Avoid declaring static activity since it will be loaded till the app is closed, though the activity life cycle is complete. 
    1. Static View - Avoid creating static view since it will hold reference of its activity in its context and when used somewhere else it would leak memory though the activity lifecycle is completed 
    1. Inner Class - When created it will have a reference to outer class which when not destoryed will stick to activity lifecycle and will not end 
    1. Anonymous class - Will also maintain a reference to the class that they were declared inside. Therefore a leak can occur if you declare and instantiate an AsyncTask anonymously inside your Activity. If it continues to perform background work after the Activity has been destroyed, the reference to the Activity will persist and it won’t be garbage collected until after the background task completes.
    1. TasksTimer - As long as they are declared and instantiated anonymously, despite the work occurring in a separate thread, they will persist a reference chain to the Activity after it has been destroyed and will yet again cause a leak.
    1. Sensor Manager - For all sensor events their respective services are to be registered a listener to activity so that the event occurrence can be notified, sometimes the developer forgets to unregister the listener or service from activity before its lifecycle ends becomes non-eligible for garbage collection
