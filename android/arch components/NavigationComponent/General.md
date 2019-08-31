## Basics

* `NavController` is powerful because when you call methods like `navigate()` or `popBackStack()`, it translates these commands 
  into the appropriate framework operations based on the type of destination you are navigating to or from. 
  For example, when you call `navigate()` with an activity destination, the NavController calls `startActivity()` on your behalf.
  
* Your NavController is associated with a NavHostFragment. Thus whichever method you use, you must be sure that the fragment, 
  view, or view ID is either a NavHostFragment itself, or has a NavHostFragment as a parent. 
  Otherwise you will get an IllegalStateException.
  
* `Navigation.createNavigateOnClickListener(@IdRes destId: int, bundle: Bundle)`. This method will build an OnClickListener 
  to navigate to the given destination with a bundle of arguments to be passed to the destination.
  
* Navigation by actions has the following benefits over navigation by destination:

    You can visualize the navigation paths through your app
    Actions can contain additional associated attributes you can set, such as a transition animation, arguments values, and backstack behavior
    You can use the plugin safe args to navigate, which you'll see shortly
