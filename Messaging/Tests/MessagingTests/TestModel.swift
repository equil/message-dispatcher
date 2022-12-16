//
//  TestModel.swift
//  
//
//  Created by Alexey Rogatkin
//

import Foundation

enum Status: String, Codable {
    case todo
    case inProgress
    case done
}

struct Person: Codable {
    let firstName: String
    let lastName: String
}

struct Task: Codable {
    let title: String
    let assignee: [Person]
    let status: Status
}

