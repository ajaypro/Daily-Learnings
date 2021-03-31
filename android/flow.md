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
*  Flow works on suspend functions and also supports back-pressure easily. Handling back-pressure through operators such as buffer
*  Flow is cold, so only when we start collecting we will get it.
*  In flow the emitted data is collected aand then the next data is emitted
