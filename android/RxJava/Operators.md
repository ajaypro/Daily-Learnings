## Operators 

  * Map vs XMap  X = (flatmap, concat map, switch map)
  * Maps transforms the applied logic to every item of the data and returns only object
  * xMap does the same but returns object or observable, we use this when we want make series of network calls one after another
  * Debounce - takes ms to wait after that passes it to down stream from upstream, if any word is typed before given ms 
  then it does not pass to downstream e.g in search operations while typing it will wait for certain time and then pass it to make n/w call.
  * DistinctUntilChanged - will only downstream when there are distinct words typed 
    e.g if im typing `ducati` and delete `i` from `ducati` then the operator will not downstream it rather it 
    will wait for any new character to be typed. 
