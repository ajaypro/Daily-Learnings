## General

* Livedata gives data and observes data from different sources. 
  * it take two arguments LiveData(lifecyclowner, observer), where it sends data to lifecycleowner only when its in active state.
  * livedata is to be created in viewmodel but not restricted. 
  * Two types of livedata 
     * livedata 
	 * Mutable livedata
	   * has two methods setValue and postValue
	   * `setValue()` should be used in main thread only
	   * `postValue()` can be from any thread to update livedata, but preferably background thread
	   * `postValue()` is the only method to update the livedata from bg thread
	   * post value will enqeue the message in the MessageQueue of the main thread via its looper. 
	   * You can send the data to main thread from any other thread in livedata using postValue
  * should register the observer of livedata onCreate() only 
  * it will be automatically removed once the lifecycleowner is finished
  * LiveData can also be used for ui which does not have lifecycle methods use `LiveData.observeForever(Observer)` 
  and we need to remove it manually by using LiveData.removeObserver(Observer)
