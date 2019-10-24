## Bascis

* *Why we need Flow* - LiveData is a simple lifecycle-aware observable, designed for making UIs that react to changes safely and efficiently. 
It can be used beyond View↔️ViewModel communications and even components like Room support it. However, there's a risk of overuse, 
especially when dealing with multiple threads.

* When we have multiple values which keeps changing such as weather data, no. of tweets
```
 val currentWeatherFlow: LiveData<String> = liveData {
    dataSource.weatherFlow().asLiveData()
 }
```
* If we want to do some transformation for each values, we cannot use map because its in mainthread so we use `switchMap`
```
val currentWeather: LiveData<String> = liveData {
    dataSource.fetchWeather().map{ // not good to use in mainthread 
    liveData{emit(heavyTransformation(it))} // coroutine context
 }
 
 val currentWeather: LiveData<String> = liveData {
    dataSource.fetchWeather().switchMap{ // good to use in mainthread 
    liveData{emit(heavyTransformation(it))}
 }
```

In flow the above example can be used with `map` opeartion in mainThread because it uses the coroutine context 

```

val currentWeatherFlow: LiveData<String> = liveData {
    dataSource.fetchWeatherFlow().map{ 
    liveData{emit(heavyTransformation(it))}
    .asLiveData() // coroutine context
```
