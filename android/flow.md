Basics
------

* A flow is cold asynchornous data stream that sequentially emits values normally or throws exception
* Flow return multiple values asynchronously, and over time, since its asynchronous the time to get response may vary from few ms to serveral secs
* It is designed based on producer and collector model where the data is emited by flow and collected, it can be restarted multiples and each time it creates 
  a new producer and emits values.
* Every flow builder internally implements coroutine which calls its corresponding suspend functions.
* The producer and consumer will run in same coroutine, so if producer is suspended so will the consumer which causes the delay in producer until 
  consumer completes

   ```
   Producer
    
   val flow = flow<String> {
      for(i in 1..10){
      emit(1000L)
      println("Hello World")
    }

   ``` 
   ```
   Consumer - consumer collecting in same coroutine which causes delay of 2 sec and then returns controls to producer which produces with 1 sec delay
   so total its prints with 3 sec delay
   
   flow.collect{
    println(it)
    delay(2000L)
   }
   
   consumer collects data in different coroutine with `flow.buffer().collect{}`
   
   flow.buffer().collect{
    println(it)
    delay(2000L)
   }
   
  ``` 
* `buffer()` operator will take arguemnts which sets its memory size in case we are dealing with continous flow of data also to be noted we might get 
    bufferoverflow error which it exceeds the size. 
*  `.collect{ }` is a terminal operator only when this is called the flow gets defined    
*  Flow works on suspend functions and also supports back-pressure easily. Handling back-pressure through operators such as buffer
*  Flow is cold, so only when we start collecting we will get it.
*  In flow the emitted data is collected aand then the next data is emitted

Flow Builders
-------------
* flow{} - create a Flow from a suspendable lambda block
```
val namesFlow = flow {
  val names = listOf("Jody", "Steve", "Lance", "Joe")
  for (name in names) {
    delay(100)
    emit(name)
  }
}

```
* channelFlow{} - uses a channel to communicate to collector
* flowOf() - for fixed set of values 

```
val namesFlow = flowOf("Jody", "Steve", "Lance", "Joe") 

```
* asFlow() - you can convert various collections and sequences to a Flow

```
val namesFlow = listOf("Jody", "Steve", "Lance", "Joe").asFlow()

```
how flow works internally
-------------------------

```
suspend fun foo(): List<Response> = buildList {
   add(compute("A"))
    add(compute("B"))
     add(compute("C"))
}

fun main() = runBlocking {
 val list = foo()
 for(x in list) println(x)

```
* Problem: Above suspend function `foo()` when called in main() (calling function) it will suspend the caller until the foo() completes its execution and main() is 
  executed, when dealing with streaming apis which gives continous values we need to get values instantly without suspending .
  * Sequences: Using sequence (data type) untill it gets values from streaming api or wss the calling method needs to wait 
  * Channels: Can get data and send in another channel to be received but channels are hot
    * e.g if producer produces a data stream and if collector channel drops the reference(i.e if collector does not receive) then the producer channel remains 
        suspend forever because there is no receiver and the job is not finished so remaining jobs will be held because there is coroutine working on other
        part of channel to produce so from receiver we cannot drop the reference and suspended forever 
  * Solution: Using different coroutines for different functions such as one coroutine to get value from foo() and simultaneously collect value in another 
   coroutine
 

Flow behind the scenes
----------------------

```
interface Flow<out T> {
 suspend fun collect(collector: FlowCollector<T>) 
}

interface FlowCollector<in T> {
  suspend fun emit(value:T)
}

```
* when collect() is implemented takes the implementation of flowcollector interface with a single emit()

FlowChain
---------

```
binding.flowChainBtn.setOnClickListener {
            CoroutineScope(Dispatchers.Main).launch {
                flowChain()
            }
        }

    }

    /**
     * flowchain to be in a  coroutine because collect() is a suspend function
     * Incase to make api calls inside flow{} we need to ensure we make them run in separate thread, since its in coroutine context
     * we have to use dispatchers and here it would be to use .flowOn(Dispatchers.IO)
     * By Default the coroutine context of producer is same for .collect() as well which preserves the context
     */
    suspend fun flowChain(){

        flow {
            Log.d(TAG, "from producer ${Thread.currentThread().name}")
            (0..10).forEach {
                // Emit items with 500 milliseconds delay
                Log.d(TAG, "Emitting  $it")
                emit(it)
            }
        }.flowOn(Dispatchers.IO) // the code above the producer runs in a worker thread and
            .collect {
                Log.d(TAG, "collect flow chain ${Thread.currentThread().name}") // this will run in dispatchers.main called where initially this is been called.
            Log.d(TAG, "from chain $it")
        }
    }

```

Intermidiate operators
----------------------

* `.buffer()` flow produces the data and internally creates a channel and uses two different coroutines one to produce and another to collect so that it can send   data simultaneously when producing it and the `.collect{}` takes the values from channel.
*  FlowContext: It is a context in which the `.collect{}` context works to get data even the producer works in same context
*  FlowOn: its changes the context of the flow that it is applied on (Basically applying dispatchers)

    ```
        dataFlow()
         .mapOn{optA()} // in contextA
         .flowOn(Dispathers.IO)
         .mapOn{optB()}

    ```
   Implementation of `flowOn` creates a separate coroutine with specified context to generate flow  and `.mapOn{optB()}` will emit in collector's context which is
  different coroutine.
* Context Preservation: the context of collector does not get leaked or progated down the stream.
* Scenario 1: 
   
     ```
        dataFlow()
         .map{optA()} // in contextA
         .flowOn(Dispathers.IO)// contextA
         .map{optB()}
         .flowOn(Dispathers.main)// context B
         .map{optC()}

       ```
* Scenario 2: 
   
    ```
        dataFlow()
         .map{optA()} // in contextA
         .flowOn(Dispathers.IO)// contextA
         .flowOn(Dispathers.main)// context B
         .map{optC()}

    ```
     optA runs on contextA as the first is given preference. 
     
## Sequences: 
* Sequences use Iterators under the hood and block while waiting for the next item. Sequences are lazily evaluated. This means they produce values as you iterate over them, instead of producing them all at once.     
* Used for synchronous streams - incoming data at regular intervals

## Streams : 
* Stream elements be emitted at different speeds — sometimes in bursts, other times in a trickle — but in many cases we’re not guaranteed to process emitted elements at all, sometimes there might not be in memory yet
* Asynchronous Stream processing: Stream processing is the processing of data in motion, computing on data directly as it is produced when the data is emitted at 
  different speeds, in bursts  which is asynchrounous in nature.


## Concurrency: 
* Concurrency is when two or more tasks can start, run, and complete in overlapping time periods. It doesn't necessarily mean they'll ever both be running at the same instant. For example, multitasking on a single-core machine.
* Concurrency is about dealing with lots of things at once. Parallelism is about doing lots of things at once.

## Parallelism: 
* It is when tasks literally run at the same time, e.g., on a multicore processor. 
* Threads in non-parallel concurrency appear to run at the same time but in reality they don't. In non - parallel concurrency threads rapidly switch and take turns to use the processor through time-slicing. While in parallelism there are multiple processors available so, multiple threads can run on different processors at the same time. 

## Structured Concurrency:  
 * Flow internally uses coroutines to produces and collect values, so scope a coroutineScope is required to launch flow so it is structured so that we can always
   cancel the scopes in our UI such as viewmodel or activity or fragment. Flow cannot work in standalone.
 * Scope of coroutines live for a limited amount of time. This time is connected to the CoroutineScope you start your coroutines in.
 * When you cancel the scope, you also release any running coroutines. The same rules apply to Kotlin Flow as well. When you cancel the scope, you also dispose of the Flow. You don’t have to free up memory manually!

## StateFlow: 

* StateFlow needs to have an initial-value, LiveData doesn't, it's an optional
* StateFlow will remain active when your app in the background, but to make is lifecycle aware in activity when we try to collect stateflow in coroutine 
  by using `launch{}` which will be active when app is in background, use `launchWhenStarted{}`then stateflow will be active on UI's started and resumed state.
* With Stateflow, you can use Flow operators, and that is something you can't do with LiveData

## Blogs

* [serach using flow](https://blog.mindorks.com/instant-search-using-kotlin-flow-operators)
  
