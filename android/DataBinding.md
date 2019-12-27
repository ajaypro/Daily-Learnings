# DataBinding
* Reduces code getting view data, showing visibility of view based on condition, `onclick` implementation, using static functions instead
of using these in class we can define them in the xml.
* Separates ui and business logic
* Internally does a null check as well
* DataBinding has a negative impact on the build speed as it uses annotation processor under the hood.

## Types

### Static data binding
* Declare a variable in xml layout file with its type then if you want to bind the data from xml you define the required data
with the variable, now in the class where you want to use this data initize databinding and we can simply call the variable by
`binding.data.variable` to get the value.  

* We can have fragment viewmodel defined with a data binding variable in mainactivity xml, and we can use this for show/hide of views or
buttons `onClick()` on the action bar that will be initialized in main activity and you wanted these views to be visible in a particular
fragment or actvitiy use the respective viewmodel defined in the xml.

* When using static functions or some Utils functions we don't have to call them in class rather we can define them as type `<import>` 
don't have to use a variable here. e.g if we have a method in Utils class such as `getdata(String)`, this we can defin in xml 
and when getting the string from textview we define there `MyClass.getData(data.user)`
Here we use import instead of variable

### Dynamic data binding
* If we want variable defined in viewmodel to observe the data changes in ui then we can define variable in viewmodel such as 
  `val price = ObservableField(double)
      price.value = 56.34`
  then in xml in the view we can define such as `android:text = "@{viewmodel.price}"`, this is dynamic data binding. 
 * when we change the data in model class it automatically reflects in UI through this type of binding
 * We can use LiveData over ObservableField so that livedata handles
    * Handles crashes - respects lifecycle of ui and will only update when they are active
    * Orientation - maintains data through orientation changes
    * no memory leaks 
 * Two way binding - passing data from viewmodel to view and from view to viewmodel 
 
DataBinding with Livedata& ViewModel
------------------------------------

* livedata objects can be directed assigned to views using databinding. 
* Defining data variable 
  ```
  <data>

        <variable
            name="gameViewModel"
            type="com.example.android.guesstheword.screens.game.GameViewModel" />
    </data>
  ```
* Assigning Viewmodel to data binding in activity/fragment class 
  ```
  binding.gameViewModel = viewModel
  ```
* Defining lifecycleOwner to for livedata to observe, This is used so that the binding can observe LiveData updates   
  ```
  binding.lifecycleOwner = this(activity/fragment)
  ```
* Now we don't have to create an observe livedata object in UI and update the views, like below
  ```
  viewModel.score.observe(this, Observer { newScore ->
   binding.scoreText.text = newScore.toString()
  })
  ```
* instead
  ```
  <TextView
   android:id="@+id/score_text"
   ...
   android:text="@{@string/score_format(gameViewModel.score)}"
   ... />
  ```
