//
//  DecodableDispatcher.swift
//  
//
//  Created by Alexey Rogatkin
//

import Foundation

/// Public protocol of message dispatcher that used to decode and handle
/// incoming messages. All messages decoding according to number of
/// registered handlers and their supported types of messages
public protocol DecodableDispatcher {
    
    ///
    /// Registers handler in the dispatching system
    ///
    /// - Parameters:
    ///     - handler: The user defined *handler* that will be used in chain of handling of incoming messages
    func register<X>(handler: X) where X: Handler, X.Message: Decodable
    
}
