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

