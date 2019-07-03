### Apply 

* Helps to work on on object after initializing without creating instance of it. the lambda function will be applied to same object
  throughout the apply function. 
  
  ```
  recyclerView.apply {
      adapter = recyclverViewAdapter
      linearLayoutManager = LinearLayoutManager
      }
    ```
 * In the above we take the initialized recyclerview use apply function, you can see that we are assigning the `adapter` and 
   `layoutmanager` within the apply block unlike tradionally
   
