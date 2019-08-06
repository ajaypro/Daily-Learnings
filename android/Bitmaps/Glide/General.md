
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
   
 ### UI unresponsiveness

   * In android ui show display in 60 frames per second and if this drops it ends up in application screen freezed or even a crash the app. 
   * The frame rate drops if there are frequent GC happening, frequent GC happens when there are objects been released frequenctly. 
   * In recyclerview or listview when the user is scrolling up or down glide downloads only images for the imageview that are visible for user
      the out of views are been GC so due to this frame rate drops and UI unresponsiveness happens. 
   * To solve this glide has Bitmap pool which will fake the JVM not to GC the free objects which reside inside this Bitmap pool. 
   * Now all the images that are not visible in the recyclerview or listview are not GCed but present in Bitmap but this increases the object size 
     that would lead to OOM again therefore we give a size to bitmap pool e.g 10 mb and we use `inBitmap` which we resuse the memory of the image 
     to load new image 	 
