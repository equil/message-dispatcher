import XCTest
@testable import Messaging



final class JSONDecodableDispatcherTests: XCTestCase {
    
    func testCommonUsage() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let messages = try [
            encoder.encode(message0),
            encoder.encode(message1),
            encoder.encode(message2),
            encoder.encode(message3),
            encoder.encode(message4),
            encoder.encode(message5),
            encoder.encode(message6),
            encoder.encode(message7),
            encoder.encode(message8)
        ]
        
        let recorder = Recorder()
        let dispatcher = JSONDecodableDispatcher(decoder: decoder)
        
        let removedAllAssigneeHandler = RemovedAllAssigneeHandler(recorder)
        dispatcher.register(handler: removedAllAssigneeHandler)
        let firstSingleAssignHandler = FirstSingleAssignHandler(recorder)
        dispatcher.register(handler: firstSingleAssignHandler)
        let changeStatusToInProgressHandler = ChangeStatusToInProgressHandler(recorder)
        dispatcher.register(handler: changeStatusToInProgressHandler)
        let changeStatusToDoneHandler = ChangeStatusToDoneHandler(recorder)
        dispatcher.register(handler: changeStatusToDoneHandler)
        let pingPongHandler = PingPongHandler(recorder)
        dispatcher.register(handler: pingPongHandler)
        let changeTitleHandler = ChangeTitleHandler(recorder)
        dispatcher.register(handler: changeTitleHandler)

        var results: [DecodableDispatcherStatus] = []
        for message in messages {
            results.append(dispatcher.handle(incomingMessage: message))
        }
        
        if case .handled(_, let handler) = results[0] {
            XCTAssert(handler is ChangeTitleHandler)
        } else {
            XCTFail()
        }
        if case .handled(_, let handler) = results[1] {
            XCTAssert(handler is RemovedAllAssigneeHandler)
        } else {
            XCTFail()
        }
        if case .handled(_, let handler) = results[2] {
            XCTAssert(handler is FirstSingleAssignHandler)
        } else {
            XCTFail()
        }
        if case .handlerNotFound = results[3] {
            XCTAssert(true)
        } else {
            XCTFail()
        }
        if case .handlerNotFound = results[4] {
            XCTAssert(true)
        } else {
            XCTFail()
        }
        if case .handled(_, let handler) = results[5] {
            XCTAssert(handler is ChangeStatusToDoneHandler)
        } else {
            XCTFail()
        }
        if case .handled(_, let handler) = results[6] {
            XCTAssert(handler is ChangeStatusToInProgressHandler)
        } else {
            XCTFail()
        }
        if case .handled(_, let handler) = results[7] {
            XCTAssert(handler is PingPongHandler)
        } else {
            XCTFail()
        }
        if case .messageNotSupported = results[8] {
            XCTAssert(true)
        } else {
            XCTFail()
        }
    }
    
}

let message0 = ChangeTitleMessage(task: Task(title: "title",
                                             assignee: [],
                                             status: .todo),
                                  previousTitle: "prev title")
let message1 = AssignMessage(task: Task(title: "title",
                                        assignee: [],
                                        status: .todo),
                             previousAssignees: [Person(firstName: "John",
                                                        lastName: "Smith")])
let message2 = AssignMessage(task: Task(title: "title",
                                        assignee: [Person(firstName: "John",
                                                          lastName: "Smith")],
                                        status: .todo),
                             previousAssignees: [])

let message3 = AssignMessage(task: Task(title: "title",
                                        assignee: [Person(firstName: "John",
                                                          lastName: "Smith")],
                                        status: .todo),
                             previousAssignees: [Person(firstName: "Sarah",
                                                        lastName: "Malloc")])

let message4 = StatusChangeMessage(task: Task(title: "title",
                                              assignee: [Person(firstName: "John",
                                                                lastName: "Smith")],
                                              status: .todo),
                                   previousStatus: .done)

let message5 = StatusChangeMessage(task: Task(title: "title",
                                              assignee: [Person(firstName: "John",
                                                                lastName: "Smith")],
                                              status: .done),
                                   previousStatus: .inProgress)

let message6 = StatusChangeMessage(task: Task(title: "title",
                                              assignee: [Person(firstName: "John",
                                                                lastName: "Smith")],
                                              status: .inProgress),
                                   previousStatus: .todo)

let message7 = "ping"

let message8 = 43
