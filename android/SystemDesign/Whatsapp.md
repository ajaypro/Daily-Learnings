## Flow 

* NewUser -> Login/Signup page opens, old user-> conversation activity opens with multiple fragments of messages, calls and status
* SplashScreen will decide whether to open login/signup or mainactivity
  * Signup will have phonenumber has input which will have country code and phone number edittext.
    Country code - we can use list to generate
    Phone no - google play services uses some libraries to detect phone number while we type and autofill it. 
    Validate phone no using external 3rd party library
    double checking validation og phone no on device and server 
* Sms retriver api to be used to retreive opt message. 
* Text messages are sent through web socket, but it cannot transfer images, videos as such. 
* client app connects with server through web socket and server makes connection to receiver app. 
* When the connection is cut, the server communicates with google server(available through google play services) and asks the receiver app 
   to connect again. 

## Transfering image, video and larger files

* Images, videos or larger files will be sent to separate server and stored there and the url will be given to client which will be 
  sent through web socket to other receiver app.
