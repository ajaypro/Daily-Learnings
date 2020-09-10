## Using glide for loading and caching bitmaps 
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
   
   #### Bitmap Pool
   * Android view should have 60 FPS so that there is no lag, if FPS is < 40 there would be huge lag that users face, this could be due 
   to various reasons such as layout rendering, n/w calls, delay in response and many other one main reason would be due to frequent
   garbage collection.
   * Frequent GC happens when objects are free to be destroyed. Example when scrolling through recyclerview maybe the top 5 items are
   ready for GC as user has scrolled down, to avoid this we can put these items in List so that its still be referenced by recyclerview to
   be shown therefore GC will not occur frequently or you can leverage BITMAP Pool if its for images or OBJECT pool in case its objects.
   * We need to reuse the memory of existing bitmapview again when a new bitmap is been loaded, this can be done with glide that provides
   option having the bitmap object created with inBitmap after decoding so that we can always load the new image into existing bitmapobject
   that is already created. Since now this holds the reference it won't be GC'ed and we need to ensure that the decoded new image is = or < 
   size of previous image if not a new bitmap object would be created. However this only reduces flickering or lag drastically but not 
   100%, further we would go about image optimization, compression algos etc...
   
   * [Managing bitmap Memory](https://developer.android.com/topic/performance/graphics/manage-memory)
   * [Caching Bitmaps](https://developer.android.com/topic/performance/graphics/cache-bitmap.html)
   * [Loading large bitmpas efficiently](https://developer.android.com/topic/performance/graphics/load-bitmap)
   * [basic code on how to use glide](https://guides.codepath.com/android/Displaying-Images-with-the-Glide-Library#setup)
   
   #### Handling image rotation after taking photo
    * Most phone cameras are landscape, meaning if you take the photo in portrait, the resulting photos will be rotated 90 degrees. In this case, the camera
      software should populate the Exif data with the orientation that the photo should be viewed in.
      Note that the below solution depends on the camera software/device manufacturer populating the Exif data, so it will work in most cases, but it is 
      not a 100% reliable solution.
    * [Very good stackoaverflow post](https://stackoverflow.com/questions/14066038/why-does-an-image-captured-using-camera-intent-gets-rotated-on-some-devices-on-a)
