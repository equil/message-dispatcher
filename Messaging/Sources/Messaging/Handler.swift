//
//  Handler.swift
//  
//  Created by Alexey Rogatkin
//

import Foundation

/// Implementors of this protocol define handling behavior and bind concrete type of messages to it
public protocol Handler {
    
    /// Associated type of messages that can be handled
    /// by concrete implementation
    associatedtype Message
    
    /// Handling of the *Message* object
    /// If the function throws any error dispatcher assumes that handler can not handle
    /// particular instance of *Message* and switch to next handler of this type if any
    ///
    /// - Parameters:
    ///     - message: instance of *Message* incoming in the system
    /// - Throws: any error if the handler doesn't ment to be target for this message
    ///
    func handle(message: Message) throws
    
}
