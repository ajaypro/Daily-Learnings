## Basics

* `@RunWith(JUnit4.class)` annotation indicates the runner that will be used to run the tests in this class. A test runner is a library or set of tools that enables testing to occur and the results to be printed to a log. 
* For espresso we use different test runners
* `@SmallTest` annotation indicates that all the tests in this class are unit tests that have no dependencies, and run in milliseconds. The `@SmallTest, @MediumTest, and @LargeTest`annotations are conventions that make it easier to bundle groups of tests into suites of similar functionality.
* You can only test methods that are public or package-protected
* if your app was written such that the input to the `add()` could be either `double` or `float` use `closeTo()`
* ViewMatchers: Hamcrest matcher expressions in the `ViewMatchers` class that lets you find a View in the current View hierarchy so that    you can examine something or perform some action.
* ViewActions: Hamcrest action expressions in the `ViewActions` class that lets you perform an action on a View found by a ViewMatcher.
* ViewAssertions: Hamcrest assertion expressions in the `ViewAssertions` class that lets you assert or check the state of a View found by  a ViewMatcher

**Testing view in Adapters**
* in an `AdapterView` such as a Spinner, the View is typically dynamically populated with child View elements at runtime. This means there  is a possibility that the View you want to test may not be in the View hierarchy at that time. 
  * The Espresso API handles this problem by providing a separate onData() entry point, which is able to first load the adapter item and bring it into focus prior to locating and performing actions on any of its children.

* The following shows how all three expressions work together:

  * Use a ViewMatcher to find a `View: onView(withId(R.id.my_view))`
  * Use a ViewAction to perform an action: `.perform(click())`
  * Use a ViewAssertion to check if the result of the action matches an assertion: `.check(matches(isDisplayed()))`
* ```
  onView(withId(R.id.my_view))
        .perform(click())
        .check(matches(isDisplayed())); 
  ```
## AndroidX Test (WIP)
* (Basics)[https://medium.com/androiddevelopers/write-once-run-everywhere-tests-on-android-88adb2ba20c5]
* (Great code lab to learn complete Testing on  livedata, viewmodel)[https://codelabs.developers.google.com/codelabs/advanced-android-kotlin-training-testing-basics/index.html?index=..%2F..index#0] 

## Mockito 
  
  * We use to @mock objects so that even when the particular operation is crashed test cases won't fail. 
  * By using @mock over objects it only check if that particular func is really called
  
  ## powermock
  
  * To mock for classes which are final
  
  ## Expresso
  
  * Exclusive for ui testing check for button or view visibility, click events, animations 
  
  ## UIAutomator 
  
  * Used for testing when your app is interacting with another app such as if you share something in whatsapp. 
  
  ## Roboelectric
  
  * Used for running tests in JVM by supporting android sdk's 
  
  ## Hamcrest
  
  * It is a matcher well suited for checking the different between two lists, their contents, if two hashmaps are the same
  
  ## Blogs
  
  * [Test robo scipts locally useful for firebase](https://android.jlelse.eu/test-robo-scripts-locally-useful-for-firebase-test-lab-pre-launch-reports-41da83d5769f)
