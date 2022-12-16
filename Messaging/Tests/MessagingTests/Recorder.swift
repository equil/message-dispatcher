//
//  File.swift
//  
//
//  Created by Alexey Rogatkin on 16.12.2022.
//

import Foundation

final class Recorder {
    
    var messages: [String] = []
    
    func record(_ message: String) {
        messages.append(message)
    }
    
}
