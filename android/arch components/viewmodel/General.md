## General

  * Maintains state across lifecycle of lifecycleowner such as activity and fragments
  * Viewmodel is cleared only when finished is called that is `onCleared()` in activity or `onDetach()` in fragment,
    does not get destroyed when activity or fragment is destroyed. 
  * Should not hold any UI reference in viewmodel as it would cause to memory leak 
  * AndroidViewModel has application passed to its constructor, whereas viewmodel does not
