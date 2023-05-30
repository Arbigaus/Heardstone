//
//  ServiceAPITest.swift
//  HeardstoneTests
//
//  Created by Gerson Arbigaus on 29/05/23.
//

import XCTest
@testable import Heardstone

final class ServiceAPITest: XCTestCase {

    var sut: ServiceAPI!
    let urlSessionMock = URLSessionMock()

    override func setUp() {
        super.setUp()
        sut = ServiceAPI()
        sut.session = urlSessionMock
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testFetchWithSuccessfulResponse() async throws {
        // Given
        let jsonData = """
        {
            "cardId": "EX1_116",
            "name": "Leeroy Jenkins",
            "cardSet": "Classic",
            "type": "Minion",
            "rarity": "Legendary"
        }
        """.data(using: .utf8)
        urlSessionMock.nextData = jsonData

        // When
        let card: Card = try await sut.fetch(from: "cards")

        // Then
        XCTAssertEqual(card.cardId, "EX1_116")
        XCTAssertEqual(card.name, "Leeroy Jenkins")
    }

    func testFetchWithErrorResponse() async throws {
        // Given
        let expectedError = NSError(domain: "Response error", code: 404)
        urlSessionMock.nextError = expectedError

        // When
        do {
            let _: Card = try await sut.fetch(from: "cards")
            XCTFail("Expected fetch to throw an error")
        } catch let error as NSError {
            // Then
            XCTAssertEqual(error.code, expectedError.code)
        }
    }
}

