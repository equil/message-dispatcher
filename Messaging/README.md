# Messaging

Messaging library is a small framework that used to decode and dispatch messages to appropriated handlers that implemented and registered by user of the library. Lets imagine that you have already implemented subsystem that can interact with backend via WebSockets. 
In our example we use incoming messages from backend that encoded as a json object or array of json objects in Data. Subsystem will continuosly call your implementation of JSONDecodableDispatcher.handle(incomingMessage:) with incoming messages and collect results of handling as DecodableDispatcherStatus.
On the other side we have a users of our library that can implement Handler protocol for any type of message they want and register implemented handler via JSONDecodableDispatcher.register(handler:) in the dispatcher.
For every incoming message dispatcher should figure out can it decode incoming Data with one of message types that bind to registered handlers and if yes then it should decode it, collect handlers that able to handle this message in order of registering and try to handle message with each handler one by one until it will find non-failed handler in queue.  
