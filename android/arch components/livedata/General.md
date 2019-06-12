## General

* Livedata gives data and observes data from different sources. 
  * it take two arguments LiveData(lifecyclowner, observer), where it sends data to lifecycleowner only when its in active state.
  * livedata is to be created in viewmodel but not restricted. 
  * Two types of livedata 
     * livedata 
	 * Mutable livedata
	   * has two methods setValue and postValue
	   * `setValue()` should be used in main thread only
	   * `postValue()` can be in any thread 
  * should register the observer of livedata onCreate() only 
  * it will be automatically removed once the lifecycleowner is finished
  * LiveData can also be used for ui which does not have lifecycle methods use `LiveData.observeForever(Observer)` 
  and we need to remove it manually by using LiveData.removeObserver(Observer)
