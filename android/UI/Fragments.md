## Basics

* While handling `onClickListener`in fragment do not use method of defining `onClick` in xml as it does not work, 
  your activity on load will look for the element in the activity, not in the fragment. 
* Better approach would be implementing `OnClickListener` to your fragment class and overriding `onCreateView` 
  in your fragment where you assign the listener to your button.

## Testing 

* Its possible to test fragments in isolation using `fragmentScenario` just like `activityScenario` its takes only one method 
  `onFragment` takes lambda and gives fragment instance.
* Also offers hooks such as testing at any state with `moveToState` and `recreate()`
* Testing with statechange 

```
@Test
fun testEventMoveToCreatedFragment(){
  val scenario = launchFragmentInContainer<EventFragment>()
  scenario.moveToState(state.CREATED)
```

* Testing with fragment recreate 

```
@Test
fun testEventMoveToCreatedFragment(){
  val scenario = launchFragmentInContainer<EventFragment>()
  scenario.recreate()
```
  
## Blogs

* [fragments common queries](https://medium.com/better-programming/android-fragments-common-queries-mistakes-1c42e9f6b44f)

## New fragment release 

* Multiple states in fragment, saving fragment view and fragment lifecycle
* testing for fragment using fragment scenario
