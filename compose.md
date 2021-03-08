Compose
-------

## why compose

* Less code, no xml, composable whatever we want 
* Use of kotlin language to build UI and accessing of android UI such as styles, themes directly using API
* Compatible with existing UI hierarchies, it can co-exist with traditional layouts so migrating huge apps will be easy.
* Everything is either configurable or composable, designs that were difficult to create before are suddenly easy **
* Supports Material Design theming and components and animations from the start.
* Data structures and algorithms are specifically geared towards making the composition and recomposition of composable as efficient and performant as possible.**
* User interfaces are broken up into small components, where state flows down from larger, parent components and events bubble up from the smaller, child components. 
  In Jetpack Compose, these components are called **Composable** functions.
* Declarative UI runtime **
* requires compiler plugin, complete UI toolkit a rewrite from groundup 
* It easier to write and maintain your app UI by providing a declarative API that allows you to render your app UI without 
  imperatively mutating frontend views(commanding changes). **

## What wrong with tradional layouts

* Android view hierarchy has been representable as a tree of UI widgets. As the state of the app changes because of things like user interactions, 
  the UI hierarchy needs to be updated to display the current data. The most common way of updating the UI is to walk the tree using functions 
  like `findViewById()`, and change nodes by calling methods like button.`setText(String), container.addChild(View), or img.setImageBitmap(Bitmap).` 
  These methods change the internal state of the widget.
* If some data is rendered in multiple places, it’s easy to forget to update one of the views that shows it. It’s also easy to create illegal states, 
  when two updates conflict in an unexpected way, For example, an update might try to set a value of a node that was just removed from the UI.

## Declarative UI

* The concept of intelligently choosing to regenerate UI to be redrawn at given time of the entire screen if any changes happen and then applying required 
 changes, This approach avoids the complexity of manually updating a stateful view hierarchy. Compose is a declarative UI framework.
 
 ## Basics

* Composable functions takes data and emit UI, needs to be annotated with composable `@Composable` annotation this informs the composable compiler plugin that 
  this function is intended to convert data into UI.

```
@Composable
fun tesla(model: String) {
   Text("I'm $model")
}
```
* The function displays text in the UI. It does so by calling the Text() composable function, which actually creates the text UI element. 
  Composable functions emit UI hierarchy by calling other composable functions. 
* The function doesn't return anything. Compose functions that emit UI do not need to return anything, because they describe the desired screen 
  state instead of constructing UI widgets.
* The function doesn't return anything. Compose functions that emit UI do not need to return anything, because they describe the desired screen 
  state instead of constructing UI widgets. The function describes the UI without any side-effects, such as modifying properties or global variables.
* In Compose's declarative approach, widgets are relatively stateless and do not expose setter or getter functions, widgets are not objects rather 
  update the UI by calling the same composable function with different arguments. This makes it easy to provide state to architectural patterns such as a ViewModel
* Composables are responsible for transforming the current application state into a UI every time the observable data updates.
* When the user interacts with the UI, the UI raises events such as onClick. Those events should notify the app logic, which can then change the app's state. 
  When the state changes, the composable functions are called again with the new data. 
  This causes the UI elements to be redrawn--this process is called **recomposition**.
* Composable functions are very sophisticated where we can use loops, if conditions to decide to show the UI elements power and flexibility is 
  one of the key advantages of Jetpack Compose.
* Composable functions can execute in any order, it has the option of recognizing that some UI elements are higher priority than others, and drawing them first.
* Composable functions can run in parallel, Compose take advantage of multiple cores, and run composable functions not on the screen at a lower priority. 
  This optimization means a composable function might execute within a pool of background threads. If a composable function calls a function on a ViewModel, Compose might call that function from several threads at the same time.
* When a composable function is invoked, the invocation might occur on a different thread from the caller. That means code that modifies variables in a composable lambda should be avoided–both because such code is not thread-safe, and because it is an impermissible side-effect of the composable lambda.

```

@Composable
@Deprecated("Example with bug")
fun ListWithBug(myList: List<String>) {
    var items = 0

    Row(horizontalArrangement = Arrangement.SpaceBetween) {
        Column {
            for (item in myList) {
                Text("Item: $item")
                items++ // Avoid! Side-effect of the column recomposing.
            }
        }
        Text("Count: $items")
    }
}

```
* In this example, items is modified with every recomposition. That could be every frame of an animation, or when the list updates. Either way, the UI will display the wrong count. Because of this, writes like this are not supported in Compose; by prohibiting those writes, we allow the framework to change threads to execute composable lambdas.

## Recomposition 

* In an imperative UI model, to change a widget, you call a setter on the widget to change its internal state. In Compose, 
  you call the composable function again with new data. Doing so causes the function to be recomposed--the widgets emitted by the function are redrawn, 
  The Compose framework can intelligently recompose only the components that changed.
* 
```
@Composable
fun ClickCounter(clicks: Int, onClick: () -> Unit) {
    Button(onClick = onClick) {
        Text("I've been clicked $clicks times")
    }
}

```
* In above function when button clicked for first time the text shows the number of clicks, again when click counter is called it will have new click data
 which is to displayed in the text so only text will be recomposed with new data and button remains the same this is how compose intelligently recomposes without
  recomposing the entire UI tree can be computationally expensive, which uses computing power and battery life. 
* Skipping all functions or lambdas that don't have changed parameters
* Composable functions should be fast to avoid jank during animations. If you need to do expensive operations, such as reading from shared preferences, do it in a    background coroutine and pass the value result to the composable function as a parameter.

## Important points to note
  
