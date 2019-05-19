# Sealed class

* Similar to enum classes but allow us to create instances with different types, unlike Enums which restrict 
us to use the same type for all enum constants.

```
enum class Phones(str: String){
Android("google play"), Apple(2)
}
```

* Enum classes allow only a single type for all constants, we can use sealed classes in this case. 
* Sealed classes allow multiple instances
* Sealed classes cannot be initiated as its constructor is private

```
   sealed class Phones{
   class Android(var model: String): Phones()
   class Apple(var model: String, var price: Int): Phones()
   class Windows(var model: String, var price: Int): Phones()
   ```
   
 * Correct use cases of sealed classes
 
 ```
    fun main(args: Array<String>){
    var van = Vehicle.vans
    van.name() // this prints maruti
    
    var city = taxis()
    city.taxicity() // this prints amsterdam`
 }
 sealed class Vehicle {
    class bike: Vehicle()
    class car: Vehicle()
    class trucks: Vehicle()
    {
        class trailers: Vehicle()
    }    
object vans: Vehicle()
{
    fun name(){
        println("maruti")
    }
 //class motorbike: Vehicle()  // out of sealed class scope   
}
}
// Outside scope of sealed class
class taxis: Vehicle() // but still works fine 
{
    fun taxicity(){
        println("amsterdam")
    }
 class motorbike: Vehicle()  // out of sealed class scope   
}
```
* [ref link](https://www.journaldev.com/18719/kotlin-sealed-class)
