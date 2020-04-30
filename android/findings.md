Adding DataBinding with livedata and viewmodel 

  * livedata objects can be directed assigned to views using databinding. 
  The @{() -> function notation creates a lambda function that takes no arguments and calls the click handler 

VM

* To separate concerns, put the click handler in the view model and the navigation in the fragment.

ui 

* Show snackbar in ui(activity/fragment) but decide that in VM 
* The android:enabled attribute is defined in TextView and inherited by all subclasses, including Button.
* The enabled attribute is not the same as the visibility attribute.

RV optimization 

/**
     * creating viewholder instance from companion object which gives class instance and therefore
     * making viewholder class private constructor so no ones calls it, moving viewholder creation from
	 * onCreateViewHolder() to viewholder class 
      */
    
    class ViewHolder private constructor(itemView: View) : RecyclerView.ViewHolder(itemView){

        companion object {
            fun from(parent: ViewGroup) = ViewHolder(LayoutInflater.from(parent.context)
                    .inflate(R.layout.list_item_sleep_night, parent, false))
        }
		
* Using ListAdapter 
 
  * We use list adapter which takes Data, VH as type and diffutil as constructor argument.
    Uses diffutil which further is implemented by asyncListDiffer which runs in bg thread to provide 
    difference in list 
  * Also internally implements getItem() and getItemCount(), we don't need to call in adapter
  * AsyncListDiffer a helper for computing differences between two lists with on DiffUtil and runs on bg thread
  
 * Data binding
 * Binding adapters are a good solution when you need to transform complex data.
 * `binding.executePendingBindings()` This call is an optimization that asks data binding to execute any pending bindings right away. 
    It's always a good idea to call `executePendingBindings()` when you use binding adapters in a RecyclerView, 
	because it can slightly speed up sizing the views.
 * [Codelab to understand databinding with RV using @bindingadapter for complex data]
    (https://codelabs.developers.google.com/codelabs/kotlin-android-training-diffutil-databinding/#6)




------------------------

bootcamp tryouts 
6.3 - use viewmodelScope instead of coroutinescope in VM's 

Activities with tasks 

Activities can be instantiated multiple times, even from other tasks.
each instance can belong to different tasks, and one task can have multiple instances.



different patterns for using click listeners in RecyclerViews

Testing 

livedata 

* dependency - testImplementation "androidx.arch.core:core-testing:$archTestingVersion"

* When using livedata to test follow these rules 

    * Use `InstantTaskExecutorRule` - annotate with @get:Rule it causes some code in the InstantTaskExecutorRule class to be run before and after the tests 
	  This rule runs all Architecture Components-related background jobs in the same thread so that the test results happen synchronously, and in a repeatable order. 
	  When you write tests that include testing LiveData, use this rule!
	  
    * Ensure LiveData observation
	
	
	reprovisioing token 
	store provisioning in 
	
* ViewModel using androidviewmodel(application) 

// AndroidX Test - JVM testing
testImplementation "androidx.test.ext:junit-ktx:$androidXTestExtKotlinRunnerVersion"
 testImplementation "androidx.test:core-ktx:$androidXTestCoreVersion"
 testImplementation "org.robolectric:robolectric:$robolectricVersion"
 testImplementation "org.jetbrains.kotlinx:kotlinx-coroutines-test:$coroutinesVersion"
 
 `runBlockingTest` - kotlinx-coroutines-test is the coroutines test library, specifically meant for testing coroutines. To run your tests, 
  use the function `runBlockingTest`. This is a function provided by the coroutines test library. It takes in a block of code and then runs this block 
  of code in a special coroutine context which runs synchronously and immediately, meaning actions will occur in a deterministic order. 
  This essentially makes your coroutines run like non-coroutines, so it is meant for testing code.
  
  Add the `@ExperimentalCoroutinesApi` above the class. This expresses that you know you're using an experimental coroutine api (runBlockingTest) in the class. 
  Without it, you'll get a warning.
 
 
* providing dependency from outside classes that avoids initializing data from source
  what if using dagger to provide dependency does it affect app start time or any other method to initialize data

    


