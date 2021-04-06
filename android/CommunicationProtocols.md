MQTT
----

* (MQTT)Message Queuing Telemetry Transport is a lightweight, publish-subscribe network protocol that transports messages between devices over TCP/IP proctocol
   and any network protocol that provides ordered, lossless, bi-directional connections can support MQTT
* MQTT has a variety of other useful features, e.g. retained messages, such that subscribers immediately receive the message, 
  and the LWT (Last Will and Testament) which is a message that can be sent automatically if the client abnormally disconnect.
* Extra abstractions on top of basic message sending, so that multiple interested parties can subscribe to messages that may interest them. 
  Messages can therefore be routed by 'message topic'.
* light weight way to publish or subscribe data, To make a constant open connection in MQTT you need Websockets AND MQTT at same time.
* Its works on the publish and subscribe model to ensure efficient communication across platforms, and also has a level system for message priority. 
  Currently, this protocol is widely used for IoT and large-scale communication because of its small footprint and minimal bandwidth consumption. 
* Despite its non-standardized status—it is currently undergoing standardization through the 
  Organization for Advancement of Structured Information (OASIS)--MQTT has already been implemented as the go-to IoT protocol by the likes of Facebook Messenger, 
  Amazon Web Services, and Microsoft Azure’s IoT Hub. The compact header size of MQTT and its QoS (Quality of Service) are geared toward
  reliable M2M communication at a fundamental level, requiring few workarounds to operate smoothly. 
* QoS in MQTT means that each message has three levels of check for guaranteeing message delivery. The levels increase bandwidth usage as they progress, 
  but higher QoS carries with it assurances at the highest level for critical transmissions.
* Well suited for IOT as it has machine to machine communication which none other protocols offer  


Http/2
------

* HTTP/2 is a modern revision of HTTP that grew from a Google experiment called SPDY, which was intended to speed up browser-side and server-side transactions. 
* The underpinnings of HTTP/2 are the same as its parent, with enhancements to network and server-side resource usage intended to lower the latency perceived 
  by the end-user. In other words, it’s HTTP/1.x, but faster. Specifically, the new protocol is utilizes multiplexing to handle TCP requests 
  instead of the ordered and blocking format used by HTTP/1, which can cause data congestion and hurt performance. 
* Also, HTTP/2 is binary rather than textual, which means it is more compact than its text-based predecessor. 
* Finally, HTTP/2 now implements server push—which allows it to push data to clients without waiting for requests—negating a deficiency that was 
  usually handled by Websockets in the previous version. HTTP/2 should work well for IoT, as its compact transmissions and low overhead will certainly
  lessen the strain on hardware in terms of memory and battery consumption. 
* the server push introduced in HTTP/2 transmits to the client, but it does not push directly to a client application. For this, many devices would still require an additional handshake 
   like the one provided by a Websocket.  

Websockets
----------

* Provides full-duplex communication channels over single TCP connection
* The client and server connect using http and then negotiate a connection upgrade to websockets, the connection then switches from http to websockets.
* The client and server can now exchange full duplex binary data over the connection.
* Allows to dispaly MQTT data directly over web-browsers 

MQTT over websockets vs MQTT
----------------------------
* Since MQTT does not directly deliver messages to client app, we use MQTT over websockets which pack the MQTT inside websocket which is packed inside TCP/IP protocol 
  and sent it at the client end it will be unpacked such as TCP/IP(unpack) -> websocket(unpack) -> MQTT message
* Standard port for MQTT over websockets is 9001
