## Basics

* Components required for video and audio calling is  lets have two clients C1 and C2
  * STUN server - Both clients connect to get their public IP that is given to each other through which they establish and start the 
                   connection.
  * WebRTC - responsible for passing data across both clients 
  * Signalling - Used for passing signals such as call cutting, muting, conference dialiing it passes the signals to other client when 
                 source client is making changes and sending signals.
   
  * TURN server - Acts like a proxy server which provides consistent connection if connection to webRTC drops. 
