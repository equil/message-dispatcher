//
//  TestMessages.swift
//  
//
//  Created by Alexey Rogatkin
//

import Foundation

struct StatusChangeMessage: Codable {
    let task: Task
    let previousStatus: Status
}

struct AssignMessage: Codable {
    let task: Task
    let previousAssignees: [Person]
}

struct ChangeTitleMessage: Codable {
    let task: Task
    let previousTitle: String
}
