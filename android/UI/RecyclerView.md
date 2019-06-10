# General

## Blogs

### For complex recyclerviews 

* [RV Optimizations](https://android.jlelse.eu/recyclerview-optimisations-a4b141dd433d)
* [Better adapters](https://proandroiddev.com/writing-better-adapters-1b09758407d2)
* [Improve performance](https://medium.com/mindorks/diffutils-improving-performance-of-recyclerview-102b254a9e4a)
* [MultiitemTypes](https://android.jlelse.eu/a-recyclerview-with-multiple-item-types-dfba3979050) - Using different layouts to load 
 into recyclerview with single adapter
* DiffUtil
  * [Nice blog](https://antonioleiva.com/recyclerview-diffutil-kotlin/)
  * [https://guides.codepath.com/android/Heterogenous-Layouts-inside-RecyclerView]
  * [https://www.android4dev.com/how-to-create-recyclerview-with-multiple-view-types/]
 
 # Performance Improvement

## Recyclerview

* Use diffUtil instead of `notify.getDataSetChanged()` as this will updated all the views
  and also few of buffers views above and below which is in appriopriate when only
  one row is changed.
* If your using images to load, ensure that they are properly decoded and also recommended
  to use suitabled libraries such as glide or fresco for better image loading from remote
  and to decode as well. 
* When clicking the selected item you can use `OnClickListener` once in `onCreateViewHolder()`
  and pass the item to be clicked to a listner outside of adapter through a interface
  avoiding object creation each time of `OnClickListener`
* Avoid calling `onBindViewHolder()` too frequently which is a potential bottle-neck for poor RecyclerView performance.
* you can use `adapter.hasStableIDs(true)` if your items have hashcode not required in
  case of using DiffUtil
* Have a flat hirearcy of layout use constraint layout and avoid nesting of layouts. 
