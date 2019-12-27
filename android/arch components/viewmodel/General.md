## General

  * Maintains state across lifecycle of lifecycleowner such as activity and fragments
  * Viewmodel is cleared only when finished is called that is `onCleared()` in activity or `onDetach()` in fragment,
    does not get destroyed when activity or fragment is destroyed. 
  * Should not hold any UI reference in viewmodel as it would cause to memory leak 
  * AndroidViewModel has application passed to its constructor, whereas viewmodel does not
  * We need to override `onCleared()` of the `ViewModel()` that we are extending to clear it also we can use it in base classes 
    to dispose disposables if any or disallocating another resources as well. 
    ```
    override fun onCleared() {
        if(!compositeDisposable.isDisposed){
            compositeDisposable.dispose()
        }
        super.onCleared()
    }
    ```
  * Creation of viewmodel is done by `ViewmodelProviders.of(context).get(yourViewmodel)`
  
  * The factory method pattern is a creational design pattern that uses factory methods to create objects. A factory method is a method that returns an instance of the same class.
  * A factory method is a method that returns an instance of the same class.
  * `ViewModelProvider` returns an existing `ViewModel` if one exists, or it creates a new one if it does not already exist.
  * `ViewModelProvider` creates a ViewModel instance in association with the given scope (an activity or a fragment).
 
 ## Viewmodel() vs Viewmodel(arg1, arg2...)
 
 * If we are using viewmodel with constructor arguments then we cannot extend with `Viewmodel()` which is provided by lifecycle library
    this viewmodel is not lifecycleaware which does not provide the purpose to use viewmodel
 * Therefore we have created a separate `newInstanceFactory` by extending `ViewModelProvider`class and providing this factory as a
    parameter to `ViewModelProviders`. 
    
    `ViewModelProviders.of(fragment, ViewModelProviderFactory(HomeViewModel::class)`
    
 * We do not dagger2 injection in this viewmodel because system is responsbile creating using `ViewmodelProviders factory` and managing the lifecycle of viewmodel that is lifecycleaware
 
 ## Blogs
 
 * [Basic clear example of viewmodel] (https://medium.com/androiddevelopers/viewmodels-a-simple-example-ed5ac416317e)
 * [Local changes and VM anipatterns](https://medium.com/androiddevelopers/locale-changes-and-the-androidviewmodel-antipattern-84eb677660d9)
 * [VM and livedata antipatterns](https://medium.com/androiddevelopers/viewmodels-and-livedata-patterns-antipatterns-21efaef74a54)
