Basics
------

* Collections are eagerly evaluated, each operation is executed on entire collection 
* New collection is created for each collection. 
```
  listOf(circle, square, rectangle, triangle)
         .map{it.copy(color = yellow)} \\ forms another new list and applies color to all shapes
         .first{it.shape == square} \\ iterate through each item until first item is found 

```
* The transformations in collections such as map, flatmap are implemented using inline function which itself creates and returns a arraylist
  function in case of map function

