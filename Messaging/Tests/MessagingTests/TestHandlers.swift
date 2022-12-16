//
//  TestHandlers.swift
//  
//
//  Created by Alexey Rogatkin
//

import Foundation
import Messaging

enum TestHandlerError: Error {
    case skip
}

struct RemovedAllAssigneeHandler: Handler {
    
    private let recorder: Recorder
    
    init(_ recorder: Recorder) {
        self.recorder = recorder
    }
    
    func handle(message: AssignMessage) throws {
        guard !message.previousAssignees.isEmpty && message.task.assignee.isEmpty else {
            throw TestHandlerError.skip
        }
        recorder.record("RemovedAllAssigneeHandler")
    }
    
}

struct FirstSingleAssignHandler: Handler {
    
    private let recorder: Recorder
    
    init(_ recorder: Recorder) {
        self.recorder = recorder
    }
    
    func handle(message: AssignMessage) throws {
        guard message.previousAssignees.isEmpty && message.task.assignee.count == 1 else {
            throw TestHandlerError.skip
        }
        recorder.record("FirstAssignHandler")
    }
    
}

struct ChangeStatusToInProgressHandler: Handler {
    
    private let recorder: Recorder
    
    init(_ recorder: Recorder) {
        self.recorder = recorder
    }
    
    func handle(message: StatusChangeMessage) throws {
        guard message.task.status == .inProgress && message.previousStatus != .inProgress else {
            throw TestHandlerError.skip
        }
        recorder.record("ChangeStatusToInProgressHandler")
    }
    
}

struct ChangeStatusToDoneHandler: Handler {
    
    private let recorder: Recorder
    
    init(_ recorder: Recorder) {
        self.recorder = recorder
    }
    
    func handle(message: StatusChangeMessage) throws {
        guard message.task.status == .done && message.previousStatus != .done else {
            throw TestHandlerError.skip
        }
        recorder.record("ChangeStatusToDoneHandler")
    }
    
}

struct PingPongHandler: Handler {
    
    private let recorder: Recorder
    
    init(_ recorder: Recorder) {
        self.recorder = recorder
    }
    
    func handle(message: String) throws {
        recorder.record("PingPongHandler")
    }
    
}

struct ChangeTitleHandler: Handler {
    
    private let recorder: Recorder
    
    init(_ recorder: Recorder) {
        self.recorder = recorder
    }
    
    func handle(message: ChangeTitleMessage) throws {
        recorder.record("ChangeTitleHandler")
    }
    
}

