# Messaging

Messaging library is a small framework that is used to decode and dispatch messages to appropriate handlers. The handlers are implemented and registered by users of the framework. Lets imagine that you have already implemented subsystem that can interact with backend via WebSockets. This framework is intermediate layer between backend interaction subsystem and parts of application that actually handle messages of different types. 

In our example we receive incoming messages from backend in form of json object or array of json objects that encoded in `Data`. Backend subsystem will continuosly call your implementation of **JSONDecodableDispatcher.handle(incomingMessage:)** with incoming messages and collect results of handling as array of **DecodableDispatcherStatus**.

On the other side we have users of our framework. They implement **Handler** protocol for any type of messages they want to be aware of and register implemented handlers via **JSONDecodableDispatcher.register(handler:)** method. **JSONDecodableDispatcher** preserve information about registered types of messages and store handlers to use them in handling routine. 

For every incoming message in **JSONDecodableDispatcher.handle(incomingMessage:)** dispatcher should figure out can it decode incoming Data with one of message types that bind to registered handlers. If yes, then dispatcher should decode it, collect handlers that able to handle this message in order of registering and try to handle message with each handler one by one until it will find non-failed handler in queue.
