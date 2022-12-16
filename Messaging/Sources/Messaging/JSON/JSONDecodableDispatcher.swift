//
//  JSONDecodableDispatcher.swift
//  
//
//  Created by Alexey Rogatkin on 16.12.2022.
//

import Foundation

public final class JSONDecodableDispatcher: DecodableDispatcher, DecodableDispatcherConnector {
    
    private let decoder: JSONDecoder
    
    public init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    public func register<X>(handler: X) where X : Handler, X.Message : Decodable {
        // TODO: implement
    }
    
    public func handle(incomingMessage: Data) -> DecodableDispatcherStatus {
        // TODO: implement
        return .messageNotSupported
    }
    
}
