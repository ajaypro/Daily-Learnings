# ConstraintLayout 

* [Constraint layout using complex UI](https://medium.com/mindorks/android-constraintlayout-explained-using-a-complex-ui-bac1702389fb)
## Circular Constraints
* [circular positioning with animation](https://medium.com/devnibbles/constraintlayout-circular-positioning-9489b11cb0e5)
* Applying constraint to center of widget relative to center of another widget
* Main attributes for circular positioning is 
	* `app:layout_constraintCircle=` give id of widget from which other widget has to be centered
        * `app:layout_constraintCircleAngle=` angle at which current widget should be placed from center widget 
        * `app:layout_constraintCircleRadius=` distance at which current widget should be placed from center widget
## Dimension Constraints
* Based on width and height this can be done in 3 ways 
* Hardcode value in dp
* WRAP_CONTENT
* use attributes `layout_constraintWidth` & `layout_constraintHeight` as these would behave w.r to given constraints
* Also has modifiers such as `android:minWidth=` `android:minHeight=` `android:maxWidth=` `android:maxHeight=` these does not work on MATCH_CONSTRAINT
* MATCH_CONSTRAINT - this is discouraged in constraint layout as it does not take constraints applied to widgets

