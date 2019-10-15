## Basics

* [How to use interfaces](https://medium.com/@rameshprasad/supercharged-interfaces-in-kotlin-53c506c53612)

* Kotlin practice - (https://exercism.io/users/sign_in)
* Solutions [link1](https://github.com/axrn/exercism-kotlin-solutions), [link2](https://github.com/rojiani/kotlin-exercism/blob/master/luhn/src/test/kotlin/LuhnTest.kt)

## Programming
* [Delegates in kotlin](https://proandroiddev.com/delegation-in-kotlin-e1efb849641)

## Coroutines

* https://github.com/Kotlin/KEEP/blob/master/proposals/coroutines.md
* [Various helper functions, delegates and extension functions for use in Coroutines](https://github.com/flatcircle/CoroutineHelper)
  
### blogs

* [coroutines-basic-terminologies](https://android.jlelse.eu/coroutines-basic-terminologies-and-usage-b4242bd1b2a4)

### Tips

* It is possible to create actual object wrappers around numbers, which is known as boxing. Boxing happens automatically, such as for collections, where numbers are boxed and unboxed as needed. Using object wrappers takes more memory than storing just a number primitive. Do not use boxing unless it is needed, such as in a collection.

* Kotlin does not implicitly convert between number types, so you can't assign a short value directly to a long variable, or a Byte to an Int. This is because implicit number conversion is a common source of errors in programs. You can always assign values of different types by casting


```
val b2: Byte = 1 // OK, literals are checked statically
println(b2)

val i1: Int = b2
⇒ error: type mismatch: inferred type is Byte but Int was expected

```
* Kotlin types can't be implicitly converted—use casting

```
val i4: Int = b2.toInt() // OK!
println(i4)
⇒ 1

```
* Kotlin allows you to place underscores in the numbers, where it makes sense to you

```
val oneMillion = 1_000_000
val socialSecurityNumber = 999_99_9999L
val hexBytes = 0xFF_EC_DE_5E

```

* initialize arrays with code instead of initializing them to 0

```
val array = Array (5) { it * 2 }
println(java.util.Arrays.toString(array))

output - [0, 2, 4, 6, 8]

```

* In Kotlin, you can loop through the elements and the indexes at the same time
```
val school = arrayOf("shark", "salmon", "minnow")
for ((index, element) in school.withIndex()) {
    println("Item at $index is $element\n")
}

output - Item at 0 is shark
Item at 1 is salmon
Item at 2 is minnow

```

* You can specify ranges of numbers or of characters, alphabetically. And as in other languages, you don't have to step forward by 1. You can step backward using downTo

```
for (i in 1..5) print(i)
⇒ 12345

for (i in 5 downTo 1) print(i)
⇒ 54321

for (i in 3..6 step 2) print(i)
⇒ 35

for (i in 'd'..'g') print (i)
⇒ defg

```

* Kotlin has repeat loops 
 
 ```
 repeat(2) {
     println("A fish is swimming")
}

output - A fish is swimmingA fish is swimming

```

* The default value for a parameter doesn't have to be a value. It can be another function. A function used as a default value is evaluated at runtime, so do not put an expensive operation like a file read or a large memory allocation in the function. The operation is executed every time your function is called, which may slow down your program

```
 fun shouldChangeWater (day: String, temperature: Int = 22, dirty: Int = getDirtySensorReading()): Boolean {
    ...
    }
```

* Using filters with eager and Sequence(lazy)

```
fun main() {
    val decorations = listOf ("rock", "pagoda", "plastic plant", "alligator", "flowerpot")

    // eager, creates a new list
    val eager = decorations.filter { it [0] == 'p' }
    println("eager: " + eager)
    
    ⇒ eager: [pagoda, plastic plant]
```
* Now applying sequence to decorations list

```
// lazy, will wait until asked to evaluate
    val filtered = decorations.asSequence().filter { it[0] == 'p' }
    println("filtered: " + filtered)
   
   filtered: kotlin.sequences.FilteringSequence@386cc1c4 // address of the list 
```
* In the above case the filtered variable will hold the sequence of elements and the filter function in the program memory, only when it is evaluated it applies the filter and returns the elements, this is also known as lazy evaluation. 

```
val lazyMap = decorations.asSequence().map{
        println("access: $it")
    }
    
    println("lazy: $lazyMap")
    println("-----")
    println("first: ${lazyMap.first()}")
    println("-----")
    println("all: ${lazyMap.toList()}")
    
    output
    
    ⇒ lazy: kotlin.sequences.TransformingSequence@5ba23b66
-----
access: rock
first: rock
-----
access: rock
access: pagoda
access: plastic plant
access: alligator
access: flowerpot
all: [rock, pagoda, plastic plant, alligator, flowerpot]
 
 ```
 * When we execute the above code the reference of the sequence `kotlin.sequences.TransformingSequence@5ba23b66` gets printed first 
   but `println("access: $it")` is not executed immediately, the first element is printed and then now the sequence is printed and then 
    all the list elements are printed.


  
  


