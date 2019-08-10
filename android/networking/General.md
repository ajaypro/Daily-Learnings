### Networking 

* Adding interceptors  for Force caching from server end - including cache-control in server response that will be received by okhttp. 
* Adding common headers on request from client to server
* Debugging at server level to get exact network time and application level to get overall okhttp logging time. 
* Etag is hashing of the response from server, for same etag the hashing is same which is checked against the server each time
    then it will provide a new e-tag
	
* While using retrofit we have to make calls using the call interface of okhttp, but if we are using Rxjava we can use 
 Single which gives success and error. 
* Single cannot be used again if once used
