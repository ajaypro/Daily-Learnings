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
    
* The backstack for a deep link is determined using the navigation graph you pass in. If the explicit Activity you've chosen has a parent activity, those parent Activities are also included.

The backstack is generated using the destinations specified with `app:startDestination` defined in `mobile_navigation.xml` which is the navigation graph. In this app we only have one activity and one level of navigation, so the backstack will take you to the home_dest destination.

* Deep linking using Navigation component is much easier than old style of using `intent-filter` and associate a URL with activity
  In the Navigation Graph mention your deep link using `<deepLink>` which has single element `app:uri` and in the manifest you 
  mention `<nav-graph android:value="@navigation/mobile_navigation" />` which internally generates intent-filter.
