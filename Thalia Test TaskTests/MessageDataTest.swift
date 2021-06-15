//
//  MessageDataTest.swift
//  Thalia Test TaskTests
//
//  Created by Özgün Yildiz on 14.06.21.
//

import XCTest
@testable import Thalia_Test_Task

class MessageDataTest: XCTestCase {
    
    func testCanParseMessages() throws {
        let json = """
        [
           {
              "title":"Hier steht der Titel der 1. Nachricht.",
              "body":" Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
              "imageUrl":"https://assets-test.thalia.media/img/artikel/ee6713c1b6ebd48682f83a149e05328010b0e640-00-03.jpeg"
           },
           {
              "title":"Hier steht der Titel der 2. Nachricht.",
              "body":" Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
              "imageUrl":"https://assets-test.thalia.media/img/artikel/ee6713c1b6ebd48682f83a149e05328010b0e640-00-03.jpeg"
           },
           {
              "title":"Hier steht der Titel der 3. Nachricht.",
              "body":" Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
              "imageUrl":"https://assets-test.thalia.media/img/artikel/ee6713c1b6ebd48682f83a149e05328010b0e640-00-03.jpeg"
           }
        ]
        """
        
        let jsonData = json.data(using: .utf8)!
        let messagesData = try! JSONDecoder().decode([Message].self, from: jsonData)
        
        XCTAssertEqual("Hier steht der Titel der 1. Nachricht.", messagesData[0].title)
        XCTAssertEqual(LOREM_IPSUM, messagesData[0].body)
        XCTAssertEqual(IMAGE_URL, messagesData[0].imageUrl)
        XCTAssertEqual("Hier steht der Titel der 2. Nachricht.", messagesData[1].title)
        XCTAssertEqual(LOREM_IPSUM, messagesData[1].body)
        XCTAssertEqual(IMAGE_URL, messagesData[1].imageUrl)
        XCTAssertEqual("Hier steht der Titel der 3. Nachricht.", messagesData[2].title)
        XCTAssertEqual(LOREM_IPSUM, messagesData[2].body)
        XCTAssertEqual(IMAGE_URL, messagesData[2].imageUrl)
        
    }
}

let LOREM_IPSUM = " Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
let IMAGE_URL = "https://assets-test.thalia.media/img/artikel/ee6713c1b6ebd48682f83a149e05328010b0e640-00-03.jpeg"
