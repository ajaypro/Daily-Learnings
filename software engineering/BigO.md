# Big O notation techniques

* [Explanation of Big O](https://medium.com/karuna-sehgal/a-simplified-explanation-of-the-big-o-notation-82523585e835)
* [Big O](https://medium.com/@bretcameron/ace-your-coding-interview-by-understanding-big-o-notation-and-write-faster-code-6b60bd498040)


## Different steps get added

`fun add(): Int {

   val sum 1 = a + b O(sum1)
   
   val sum 2 = c+ d O(sum2)
   
   return sum1+sum2`
   
   runtime O(sum1 + sum2)
 
 ## drop constants

`fun minMax(array:Array){
   var min, max = null
   forEach(e in array)
    min = MIN(e, array)
   forEach(e in array)
    max = MAX(e, array)
	}`
	
  runtime O(2N)
  
  `fun minMax(array:Array){
	var min, max = null 
	forEach(e in array)
	 min = MIN(e, array)
    max = MAX(e, array)
	}`
  
  runtime O(N)
  
 Both operations are same therefore is ok to write O(N), instead of O(2N)
 dropping constants
 
 ## Different inputs => different variables
 
 `int intersectionSize(array: Array) {
  var count = 0 
  for a in array {
   for b in array {
     if (a == b) {
      count++
} 
}
}`

runtime will be O (a * b) not O (n^2) : as these are two different variables and each variable runtime 
to be taken into account which results in O (a * b) 

## drop non-dominate terms

`fun something(array: Array) {
 forEach(e in array)
    min = MIN(e, array)	
	forEach e in array {
	  forEach f in array {
	   print a, b 
	} } }`
  
  in this the above operation is O(N) and below is O(N^2), we can avoid O(N) as it is
non dominant compared with O(N^2) 

