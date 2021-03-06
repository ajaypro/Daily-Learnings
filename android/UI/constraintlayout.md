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

## Chains
* Chain constraint of constraintlayout is used to create bi-directional connection between widgets
* Has 3 styles 
	* spread - all widgets are equally spread
	* spreadinside - Will be spread inside endpoints but endpoints will stick the parent
	* packed - All widgets will be placed close to each other without space but will consider margin
	* attributes used are 
		* app:layout_constraintHorizontal_chainStyle=[spread/spread inside/packed]
		* app:layout_constraintVertical_chainStyle=[spread/spread inside/packed]
		
## Videos
* https://www.youtube.com/watch?v=P2XHNDHI4PQ - chains, circular constraints, dimension constraints, other usage

# Cons
* Constraint layout has scroll issues with recyclerview that is if you place recyclerview inside constraintlayout,However if you can give 
  `android:layout_height = some dp` rather than `wrap_content` then it works fine, but this is not a best practice all the time.
* if you have recyclerview details layout designed with  constraint layout UI would be fine by roboelectric test would not scroll to
  last position so use espresso to test UI. 
* Do not use `constraintTop_toTop` and `constraintBottom_toBottom` when you have vertical guidleine as it causes an error that you would be unaware of it. Only use these with horizontal guideline and for vertical guideline use `constraintLeft_to..` & `constraintRight_to..`
