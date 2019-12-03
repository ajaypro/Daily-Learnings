##Basics

* `@RunWith(JUnit4.class)` annotation indicates the runner that will be used to run the tests in this class. A test runner is a library or set of tools that enables testing to occur and the results to be printed to a log. 
* For espresso we use different test runners
* `@SmallTest` annotation indicates that all the tests in this class are unit tests that have no dependencies, and run in milliseconds. The `@SmallTest, @MediumTest, and @LargeTest`annotations are conventions that make it easier to bundle groups of tests into suites of similar functionality.
* You can only test methods that are public or package-protected
* if your app was written such that the input to the `add()` could be either `double` or `float` use `closeTo()`
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
