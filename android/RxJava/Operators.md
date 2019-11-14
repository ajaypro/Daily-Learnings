## Operators 

  * [Operators very good explanation with examples](https://codingwithmitch.com/courses/rxjava-rxandroid-for-beginners/transformation-operators-switchmap/)
  * Map vs XMap  X = (flatmap, concat map, switch map)
  * Maps transforms the applied logic to every item of the data and returns only object
  * xMap does the same but returns object or observable, we use this when we want make series of network calls one after another
  * Debounce - takes ms to wait after that passes it to down stream from upstream, if any word is typed before given ms 
  then it does not pass to downstream e.g in search operations while typing it will wait for certain time and then pass it to make n/w call.
  * DistinctUntilChanged - will only downstream when there are distinct words typed 
    e.g if im typing `ducati` and delete `i` from `ducati` then the operator will not downstream it rather it 
    will wait for any new character to be typed. 
 # Filter operators 
   * filter, distinct, take, takewhile 
 # Transformation operators 
   * Map, buffer, debounce, switchMap, flatmap, concatMap, throttleFirst
 
 * **Rxbinding** library offers debounce, throttleFirst, buffer, debounce
    
## Time vs Delay vs Interval

* [Time vs Delay vs Interval](https://blog.mindorks.com/understanding-rxjava-timer-delay-and-interval-operators)

## Map vs Flatmap

* [Very nice explanation with examples](https://stackoverflow.com/questions/22847105/when-do-you-use-map-vs-flatmap-in-rxjava)
* [blog](https://medium.com/mindorks/rxjava-operator-map-vs-flatmap-427c09678784)

* `ThrottleFirst()` - does emit until certain time interval is reached. Good for button click spamming
* `Buffer()` - gather all emissions from source observable into bundles and emits them together.
* `SwitchMap()` **Maintains order** - will transform items emitted by an Observable into an Observable just like ConcatMap() and FlatMap(). The difference being that it will unsubscribe previous observers once a new Observer has subscribed. Essentially this solves a limitation that both ConcatMap() and FlatMap() have. 
* `ConcatMap()` **Maintains order** - Transform the item(s) emitted by an Observable into Observables, then flatten the emissions from those into a single Observable. This operator is essentially the same as the Flatmap operator, but it emits the object(s)


