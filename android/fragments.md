# Fragments
* They have their own life cycle and are bounded by activities 
* You can add or remove fragments while still your activity is running
* You can combine multiple fragments in a single activity to build a multi-pane UI.
* A fragment can be used in multiple activities.
* When the activity is paused, all the fragments available in the activity will also be stopped.
* A fragment can implement a behavior that has no user interface component.
* Use intents to communicate between fragments startActivity() carries data with it 
* The method getLoaderManager() is only available in the Fragment class. 
* To get a LoaderManager in a FragmentActivity, call getSupportLoadManager().
* [activity vs fragment](https://stackoverflow.com/questions/23004519/activity-vs-fragment-lifecycle)
* All subclasses of fragment will have no-arg constructor which helps in state restore, 
  The framework will often re-instantiate a fragment class when needed, in particular during state restore, 
  and needs to be able to find this constructor to instantiate it.
* ListFragment contains listView 
* Headless fragments are used for common code usage like internet connectivity, permissions check, 
  which is like a replacement of base class of activity which can be extended only once whereas fragments 
  can reused by actvities.
* To remove fragments from backstack use `remove()`and to remove multiple fragments from backstack use 
 `popBackStack()` or `popBackStack(string, POP_BACK_STACK_INCLUSIVE)`
