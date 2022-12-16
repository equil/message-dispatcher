//
//  DecodableDispatcherConnector.swift
//  
//
//  Created by Alexey Rogatkin.
//

import Foundation

public protocol DecodableDispatcherConnector {
    
    /// Method called when new encoded message arrive in the system
    ///
    /// - Parameters:
    ///     - incomingMessage: Message that encoded in Data and should be dispatched to appropiate handler with matched type
    ///
    /// - Returns: The status of handling
    ///
    func handle(incomingMessage: Data) -> DecodableDispatcherStatus
    
}

///
/// Status of handled data
///
public enum DecodableDispatcherStatus {
    
    ///
    /// Data has been successfully handled
    ///
    /// - Parameters:
    ///     - message: decoded message from data
    ///     - by: handler object that successfully handled data
    ///
    case handled(message: Decodable, by: any Handler)
    
    ///
    /// Data has been decoded in supported message type, but non of the related handlers successfully handled it
    ///
    /// - Parameters:
    ///     - message: decoded message from data
    ///     - errors: array of errors with related handlers. Size of array is identical to count of registered handlers for this type of message
    ///
    case handlerNotFound(message: Decodable, errors: [(any Handler, Error)])
    
    ///
    /// This type of message isn't supported, e.g. no handlers registered for it
    ///
    case messageNotSupported
    
}
