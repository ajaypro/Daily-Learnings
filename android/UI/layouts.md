
Basics
------

* ~16 milliseconds to render a single frame to avoid any janky behaviour in the app
* app processes an object for layout, the app performs the same process on all children of the layout the framework executes the layout or 
  measure stage in a single pass and quite quickly.
* complicated layouts may have to iterate multiple times on parts of the hierarchy that require multiple passes to resolve before ultimately positioning 
  the elements.
* Having to perform more than one layout-and-measure iteration is referred to as DOUBLE TAXATION
  * A LinearLayout with layout_weight needs each child to be measured twice.
  * GridLayout with weights or fill gravity makes it lose all the pre-processing benefits.
  * RelativeLayout always takes at least 2 passes

Grid Layout
-----------
* `GridLayout` arranges items in a grid of rows and columns. Assuming vertical scrolling, by default, each item in a row takes up one "span." 
  (In this case, one span is equivalent to the width of one column.)
  
Relative Layout
---------------
* draws child views relative to one another by using relative layout params. 
* draws double container to position child views next to one another to measure and finalize the position and rendering
  * first layout containerpass check the views and their sizes to be postioned, 
  * second layout container pass relative layout uses to reposition and make boundary adjustments to place the views 
  * These two keeps happening for every change in relative layout.
  
Linear Layout
-------------

* Default orientation is horizontal and places child views based on layout_weight attribute which is performance heavy
* Also behaves double layout behaviour when there a measureWithLargeChild  attribute used

