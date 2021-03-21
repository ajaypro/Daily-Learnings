## Basics

* gRPC is a remote procedure call system developed in Google, and it allows us to call some function on the remote server like it’s a usual 
  local function in our app. Therefore you don’t need to handle any HTTP related stuff because the networking logic is abstracted away from the app.
* The gRPC solution is typically chosen when the backend has a microservice architecture or when you need to stream or observe a large amount of data. 
  This is possible because the gRPC is built on top of the HTTP/2 protocol, supporting bidirectional streaming and using efficient Protocol Buffers for 
  the data transfer. 
* [Basics google dev link](https://developer.android.com/guide/topics/connectivity/grpc?authuser=1)
* [gRPC Kotlin](https://developers.googleblog.com/2020/12/announcing-grpc-kotlin-10-for-android.html)
### Bidirectional streaming:  
 * Both the client and the server sends multiple messages to each other. Using this type of rpc call, can be a little bit more complicated, 
   since you have to take care of error handling from the server side and the client side.
### HTTP1 vs HTTP2: 
 * HTTP/1.1 practically allows only one outstanding request per TCP connection blocking nature of HTTP/1.1 is a major bottleneck for faster loading applications.
 * Duplication of Data: The other problem with HTTP/1.1 is the duplication of data across requests (cookies and other headers). 
   Too many requests means too much redundant data, which would impact performance.
 * Single request per connection. Because HTTP can only fetch one resource at a time (HTTP pipelining helps, but still enforces only a FIFO queue), 
   a server delay of 500 ms prevents reuse of the TCP channel for additional requests 
 * Exclusively client-initiated requests.
 * Uncompressed request and response headers. Request headers today vary in size from ~200 bytes to over 2KB. As applications use more cookies and user agents expand features, 
   typical header sizes of 700-800 bytes is common. 
 * Redundant headers. In addition, several headers are repeatedly sent across requests on the same channel.
 * Optional data compression. HTTP uses optional compression encodings for data. Content should always be sent in a compressed format.
 * HTTP/2 was built over Google’s SPDY protocol with the above shortcomings of HTTP/1.1 kept in mind. 
 * Once the first few assets start loading over HTTP/2, the following assets are loaded very quickly. This is not the case with HTTP/1.1, 
   where the image assets keep loading for a longer time one after another (typical to pipelining in HTTP/1.1) to complete the full image.

 ## SPDY

 * SPDY compresses request and response HTTP headers, resulting in fewer packets and fewer bytes transmitted.
 * SPDY adds a session layer atop of SSL that allows for multiple concurrent, interleaved streams over a single TCP connection. The usual HTTP GET and POST message formats remain the same; 
   however, SPDY specifies a new framing format for encoding and transmitting the data over the wire.
 * Streams are bi-directional, i.e. can be initiated by the client and server. SPDY aims to achieve lower latency through basic (always enabled) and advanced (optionally enabled) features.
 * SPDY implements request priorities: the client can request as many items as it wants from the server, and assign a priority to each request. This prevents the network channel from being 
   congested with non-critical resources when a high priority request is pending. 
 * Server Push: SPDY experiments with an option for servers to push data to clients via the X-Associated-Content header. 
    This header informs the client that the server is pushing a resource to the client before the client has asked for it.  
    For initial-page downloads (e.g. the first time a user visits a site), this can vastly enhance the user experience.
 

