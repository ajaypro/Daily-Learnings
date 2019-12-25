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

* `NavHostFragment` user moves between destinations defined in the navigation graph, swaps the fragments in and out and manages the fragment back stack.
* Call `findNavController().navigate()`on the view, passing in the ID for the appropriate action.
* Using `popTo` attribute we can define the destination when user clicks the Back Button
* when `Inclusive` option if checked the value is true and all destinations upto and including destination are removed from backstack.
* To handle `UpButton` Navgiation controller's `NavigationUI` library is used integrates with the app bar to allow the user to tap the Up button on the app bar to get back to the app's home screen from anywhere in the app.
```
val navController = this.findNavController(R.id.myNavHostFragment)
NavigationUI.setupActionBarWithNavController(this,navController)
```
* Override the `onSupportNavigateUp()` to call `navigateUp()` in the navigation controller

```
override fun onSupportNavigateUp(): Boolean {
        val navController = this.findNavController(R.id.myNavHostFragment)
        return navController.navigateUp()
    }
}
```
* For setting up navigation drawer and options menu please check [here](https://codelabs.developers.google.com/codelabs/kotlin-android-training-add-navigation/index.html?index=..%2F..android-kotlin-fundamentals#11)

* SafeArgs: Starting external activity using intents with Safeargs which offers `NavDirection` classes
* [Please check here](https://codelabs.developers.google.com/codelabs/kotlin-android-training-start-external-activity/index.html#6)
