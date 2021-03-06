### Info
* Glides uses java heap to store the images, whereas Bitmap / Media resources memory allocation comes from Native memory, but Bitmap cache memory is counted from java heap memory per app, which is why we receive OOM for larger bitmaps. 
* **CHECK** - start the application and check the memory dump after some usage of the app using glide. It clearly shows that it keeps in Java heap memory


### Problems if not using image library 
 
 * While downloading we need to down sample the image to the required size to display in the view
 * Images need to be decoded and compress always before displaying in ui
 * As images might be larger in size and quality, they create large objects which would take more memory and provide window for frequent GC's.
 
 Most image libraries to be used in android does solve these problems with minor difference between each of them. 
 
 * Glides solves OOM, UI unresponsiveness, slow loading
 
 ### OOM 
 
 * Occurs due to objects trying to occupy more memory which is not available, when we download and try to show image in imageview
   if the image size is large then it ends up with OOM, glide solves this by down sampling the image into required size which further 
   reduces the size and resolution but not the quality. 
 
 ### Slow loading 
  
   * This happens when image is been loaded into the imageview. 
   * Glides first fetches the image from memory and loads if its not there then it looks into disk, if its not there then it downloads 
      from n/w and puts them in disk and memory, by doing slow loading is avoided in glide. 
   * When it fetches image from server it does place it in disk cache and does the transformations of converting the image of 1000*1000
    to 200 * 200 as per `imageView` size and then put them in cache for quick retreival  
   
 ### UI unresponsiveness

   * In android ui show display in 60 frames per second and if this drops it ends up in application screen freezed or even a crash the app. 
   * The frame rate drops if there are frequent GC happening, frequent GC happens when there are objects been released frequenctly. 
   * In recyclerview or listview when the user is scrolling up or down glide downloads only images for the imageview that are visible for user
      the out of views are been GC so due to this frame rate drops and UI unresponsiveness happens. 
   * To solve this glide has Bitmap pool which will fake the JVM not to GC the free objects which reside inside this Bitmap pool. 
   * Now all the images that are not visible in the recyclerview or listview are not GCed but present in Bitmap but this increases the      object size that would lead to OOM again therefore we give a size to bitmap pool e.g 10 mb and we use `inBitmap` which we resuse the memory of the image to load new image 	
   
 ### Blogs 
 
 * [Glide from basic to advance topic with code in github](https://medium.com/@elye.project/glide-image-loader-the-basic-798db220bb44)
 * [Invalidating single image in glide](https://bumptech.github.io/glide/doc/caching.html#cache-invalidation)
 * [Tips using Glide](https://android.jlelse.eu/using-glide-few-tips-to-be-a-pro-60f41e29d30a)
 
 ### Sample workout
 
 * [Showing image with glide](https://blog.mindorks.com/downloading-and-showing-image-with-glide-library-in-android)
 * [Glide samples](https://bumptech.github.io/glide/ref/samples.html)
 
