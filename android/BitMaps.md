## Using glide for loading and cache in bitmaps 
### General tips
* You need to change the url of the image if the image is changed 
### Solving slow loading and OOM issues 
* OOM - glides down samples the images downloaded from server to that which is required to load in android view. This is decoding the image
which reduces the size without altering the quality of the image that will be rendered. By this technique it solves the OOM when loading
image or bitmaps. 
* Slow rendering
  #### Scrolling to any middle item in recycler view 
   * Glide fetches the image only for this view that is currently viewed by user so that the is is visible cancelling the other n/w calls
    to above or below items. 
   * Glide also fetches items based on if user scrolls top to bottom (prefetching the items) that are within the view of recyclerview
  #### User scrolling again to same direction in recyclerview
   * Glides fetches image or bitmap from the memory cache (RAM - Java heap) to display which is quicker rather than making a n/w call
   * Glide initially looks into memory cache if image is not found it looks into disk cache( file system) and finally makes a n/w call
   and keeps a copy in disk cache and memory cache so that it displays it quicker in the rendered view, thus avoiding slow rendering of 
   images into the view. 
   * Memory Cache stores the images interanally with its respectice url as a key and image as its value. 
   * When user moves from FragmentA to Fragment B and fragmentA is destroyed when the user returns to fragmentB then it uses memory cache 
   to get the image, in case if the application is killed and when user reopens the app again then its uses disk cache or makes a n/w call
   based on image availability, as the memory cache will be erased. 