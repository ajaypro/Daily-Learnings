## Basics

* While handling `onClickListener`in fragment do not use method of defining `onClick` in xml as it does not work, 
  your activity on load will look for the element in the activity, not in the fragment. 
* Better approach would be implementing `OnClickListener` to your fragment class and overriding `onCreateView` 
  in your fragment where you assign the listener to your button.
