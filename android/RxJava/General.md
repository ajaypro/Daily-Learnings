## General

  * Rxjava is a java VM implementation of Reactive Extensions
  * Reactive Extensions is library for composing asynchronus, event-based programs by using observables
  * If your sure about the task you know the time taken e.g like image processing use computation 
  and if your unsure about the task like network call, file move or copy, db operaion use io schedulers
  * RxAndroid extends RxJava to provide main thread schedulers, loopers, handlers to Rxjava as it is a library thats how we get 
   `AndroidSchedulers.mainThread()`
  * Every library has rxjava version which is to be leveraged to work easily.
  * Every Observable will be subscribed to observers or consumers, when its observers the `subscribeOn()` will return void as the 
    observer has `onSubscribe()` which takes disposables, if its consumer the `subscribe` will return disposable
  * `disposable.clear()` - its clears the observers subscribed to observables  
  * `disposable.dispose()` - its clears both observers and observables. 
   
## Blogs

* [RxJava explanation blogs](https://medium.com/tompee/tagged/rxjava-ninja)
* [Rxjava example - file uploader](https://academy.realm.io/posts/jag-saund-advanced-rxjava-through-concrete-android-examples/)
* [Disposable](https://medium.com/@elye.project/rxjava-2-wheres-disposable-when-subscribe-observer-4ec16049f2e1)
* [Understanding what is disposable under the hood](https://medium.com/@vanniktech/rxjava-2-disposable-under-the-hood-f842d2373e64)
* [Rxjava examples - realtime cases](https://github.com/kaushikgopal/RxJava-Android-Samples)
* [Complete Rx java with examples and explanation](https://proandroiddev.com/rxjava-different-types-of-subjects-ef9183b5e87e)
* [https://www.baeldung.com/rxkotlin](Rxkotlin)
* [https://code.tutsplus.com/tutorials/kotlin-reactive-programming-with-rxjava-and-rxkotlin--cms-31577](Rxkotlin)
* **YTT**[Rxjava with kotlin baby steps very good for details](https://proandroiddev.com/notes-rx-java-with-kotlin-in-baby-steps-w-annyce-davis-8a49ffdba72c)


