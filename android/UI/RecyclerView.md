# General

## Blogs

### For complex recyclerviews 

* [Basics of RV](https://medium.com/@nileshsingh/understanding-recyclerview-part-1-the-basics-a7bd07cfae93)
  [Link2](https://developer.android.com/guide/topics/ui/layout/recyclerview)
* [RV Optimizations](https://android.jlelse.eu/recyclerview-optimisations-a4b141dd433d)
* [Better adapters](https://proandroiddev.com/writing-better-adapters-1b09758407d2)
* [Improve performance](https://medium.com/mindorks/diffutils-improving-performance-of-recyclerview-102b254a9e4a)
* [MultiitemTypes](https://android.jlelse.eu/a-recyclerview-with-multiple-item-types-dfba3979050) - Using different layouts to load 
 into recyclerview with single adapter
* [Animation](https://medium.com/better-programming/android-recyclerview-with-beautiful-animations-5e9b34dbb0fa)
* **YTP** [parallex animation](https://medium.com/@patrick_iv/add-extra-depth-to-your-list-using-parallax-eddb27b369de)
* DiffUtil
  * [Nice blog](https://antonioleiva.com/recyclerview-diffutil-kotlin/)
  * [https://guides.codepath.com/android/Heterogenous-Layouts-inside-RecyclerView]
  * [https://www.android4dev.com/how-to-create-recyclerview-with-multiple-view-types/]

## Blogs

* [Expandable RecyclerView](https://android.jlelse.eu/get-expandable-recyclerview-in-a-simple-way-8946046b4573)
* [delete, undo, swipe](https://medium.com/@zackcosborn/step-by-step-recyclerview-swipe-to-delete-and-undo-7bbae1fce27e)
* [Generic Recyclerview for multiple lists](https://medium.com/hackernoon/recyclerview-plus-assign-kotlin-power-6f93ce980154)
 
## Basics 

* `class TextItemViewHolder(val textView: TextView): RecyclerView.ViewHolder(textView)` 
* RV does not use texview to display items directly.
* A ViewHolder describes an item view and metadata about its place within the RecyclerView
* RecyclerView relies on this functionality to correctly position the view as the list scrolls, and to do interesting things like animate views when items are added or removed in the Adapter.
* If RecyclerView does need to access the views stored in the ViewHolder, it can do so using the view holder's itemView property. RecyclerView uses itemView when it's binding an item to display on the screen, when drawing decorations around a view like a border, and for implementing accessibility. 

 # Performance Improvement

## Recyclerview

 * Use diffUtil instead of `notify.getDataSetChanged()` as this will updated all the views and also few of buffers views above and below    which is in appriopriate when only one row is changed,  by using this method, there is no way for the RecyclerView to know what the actual changes in the data set are. Thus, it is assumed that all current items and data are invalid. That is why all visible views will be recreated again. This sounds like an expensive operation.
* If your using images to load, ensure that they are properly decoded and also recommended to use suitabled libraries such as glide or fresco for better image loading from remote and to decode as well. 
* When clicking the selected item you can use `OnClickListener` once in `onCreateViewHolder()`and pass the item to be clicked to a listner outside of adapter through a interface avoiding object creation each time of `OnClickListener`
* Avoid calling `onBindViewHolder()` too frequently which is a potential bottle-neck for poor RecyclerView performance.
* you can use `adapter.hasStableIDs(true)` if your items have hashcode not required in case of using DiffUtil.
* Have a flat hirearcy of layout use constraint layout and avoid nesting of layouts. 
* DiffUtil uses these methods to notify the RecyclerView for any changes in the data set:

    notifyItemMoved
    notifyItemRangeChanged
    notifyItemRangeInserted
    notifyItemRangeRemoved
 
 POM - ListAdapter
 -----------
 
 * We use list adapter which takes Data, VH as type and diffutil as constructor argument.
    Uses diffutil which further is implemented by asyncListDiffer which runs in bg thread to provide 
    difference in list 
  * Also internally implements getItem() and getItemCount(), we don't need to call in adapter
  * AsyncListDiffer a helper for computing differences between two lists with on DiffUtil and runs on bg thread
  * Your code needs to tell the ListAdapter when a changed list is available. ListAdapter provides a method called 
    submitList() to tell ListAdapter that a new version of the list is available. When this method is called, the ListAdapter diffs 
    the new list against the old one and detects items that were added, removed, moved, or changed
  * [in depth blog](https://medium.com/@hackathon.blog.42/listadapter-renewed-9b5b496198e2)
  
POM - ViewHolder as singleton
------------------------

* creating viewholder instance from companion object which gives class instance and therefore
* making viewholder class private constructor so no ones calls it, moving viewholder creation from onCreateViewHolder() to viewholder class
e.g 
 ```
 class ViewHolder private constructor(itemView: View) : RecyclerView.ViewHolder(itemView){

        companion object {
            fun from(parent: ViewGroup) = ViewHolder(LayoutInflater.from(parent.context)
                    .inflate(R.layout.list_item_sleep_night, parent, false))
        }
  ```
  In the `onCreateViewHolder()` 
   
   ```
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = from(parent)
   ```
     
 ## Repos
 
 * [To practice](https://github.com/googlesamples/android-sunflower)
