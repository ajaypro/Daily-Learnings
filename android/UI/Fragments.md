## Basics

* While handling `onClickListener`in fragment do not use method of defining `onClick` in xml as it does not work, 
  your activity on load will look for the element in the activity, not in the fragment. 
* Better approach would be implementing `OnClickListener` to your fragment class and overriding `onCreateView` 
  in your fragment where you assign the listener to your button.
**Fragment.newInstance()** - Creating this method in fragment, because when android decides to recreate fragment it will call noargs
 constructor of the fragment only so overloading a constructor in fragment is of no use. 
 Instead creating this static method and passing arguments to it as bundle and setarguments to fragment, we can call this in fragment's 
 `onCreate()`. 
 ```
  public static MyFragment newInstance(int someInt) {
    MyFragment myFragment = new MyFragment();

    Bundle args = new Bundle();
    args.putInt("someInt", someInt);
    myFragment.setArguments(args);

    return myFragment;
}
 ```
 * This Bundle will be available even if the Fragment is somehow recreated by Android.
 * `setArguments` can only be called before the Fragment is attached to the Activity.
  
Android OS displaying Dynamic Layouts of fragments
--------------------------------------------------

* Depending upon the orientation the device is set initially or going by device screen size it looks for qualifiers in layout folder
  such a `layout-prod` and `layout-land` if not then it start looking into default layout



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
* [Very Useful fragment scenarios](https://androidlearnersite.wordpress.com/2017/02/27/fragment-lifecycle-during-fragment-transaction/)

## New fragment release 

* Multiple states in fragment, saving fragment view and fragment lifecycle
* testing for fragment using fragment scenario
