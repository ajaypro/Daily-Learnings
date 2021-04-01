Basics
------

* A flow is cold asynchornous data stream that sequentially emits values normally or throws exception
* Flow is basically to handle asynchronous stream of data coming from server to client side(android)
* It is designed based on producer and collector model where the data is emited by flow and collected
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

how flow works internally
-------------------------
* Problem: Below suspend function when called in main() (calling function) it will suspend the caller until the foo() completes its execution and main() is 
  executed, when dealing with streaming apis which gives continous values we need to get values instantly without suspending .
  * Sequences: Using sequence (data type) untill it gets values from streaming api or wss the calling method needs to wait 
  * Channels: Can get data and send in another channel to be received but channels are hot
    * e.g if producer produces a data stream and if collector channel drops the reference(i.e if collector does not receive) then the producer channel remains 
        suspend forever because there is no receiver and the job is not finished so remaining jobs will be held because there is coroutine working on other
        part of channel to produce so from receiver we cannot be drop the reference and suspended forever 
  * Solution: Using different coroutines for different functions such as one coroutine to get value from foo() and simultaneously collect value in another 
   coroutine
 
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

Intermidiate operators
----------------------

* `.buffer()` flow produces the data and internally creates a channel and uses two different coroutines one to produce and another to collect so that it can send   data simultaneously when producing it and the `.collect{}` takes the values from channel.
*  FlowContext: It is a context in which the `.collect{}` context works to get data even the producer works in same context
*  FlowOn: its changes the context of the flow that it is applied on (Basically applying dispatchers)
   e.g  ```
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

## Structured Concurrency:  
 * Flow internally uses coroutines to produces and collect values, so scope a coroutineScope is required to launch flow so it is structured so that we can always
   cancel the scopes in our UI such as viewmodel or activity or fragment. Flow cannot work in standalone.

## Concurrency: 
* Concurrency is when two or more tasks can start, run, and complete in overlapping time periods. It doesn't necessarily mean they'll ever both be running at the same instant. For example, multitasking on a single-core machine.

* Parallelism is when tasks literally run at the same time, e.g., on a multicore processor. 
* Threads in non-parallel concurrency appear to run at the same time but in reality they don't. In non - parallel concurrency threads rapidly switch and take turns to use the processor through time-slicing. While in parallelism there are multiple processors available so, multiple threads can run on different processors at the same time. 
  
