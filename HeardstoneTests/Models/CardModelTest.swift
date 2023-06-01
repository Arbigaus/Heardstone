//
//  CardModelTest.swift
//  HeardstoneTests
//
//  Created by Gerson Arbigaus on 29/05/23.
//

import XCTest
@testable import Heardstone

final class CardModelTest: XCTestCase {

    func testFetchCardList() async throws {
        let mockService = MockServiceAPI()
        let cardModel = CardModel(service: mockService)
        let mockCards = [createSampleCard(), createSampleCard()] // assuming Card has a default initializer

        // Set the mock service to return the mock cards.
        mockService.result = mockCards

        do {
            let cards = try await cardModel.fetchCardList()
            XCTAssertEqual(cards.count, 2)
            XCTAssertEqual(mockCards, cards)
        } catch {
            XCTFail("Expected call to not throw, but it did: \(error)")
        }
    }

    func testFetchCardListFailure() async throws {
        let mockService = MockServiceAPI()
        let cardModel = CardModel(service: mockService)
        let testError = NSError(domain: "Test", code: 999, userInfo: nil)

        // Set the mock service to throw an error.
        mockService.error = testError

        do {
            let cards = try await cardModel.fetchCardList()
            XCTAssertEqual(cards.count, 0, "Expected card list to be empty on failure, but it was not")
        } catch {
            XCTFail("Expected call to not throw, but it did: \(error)")
        }
    }

    private func createSampleCard() -> Card {
        let sampleURL = URL(string: "https://example.com")!

        let card = Card(
            cardId: "1234",
            dbfId: 5678,
            name: "Example Card",
            cardSet: "Set Name",
            type: "Minion",
            rarity: "Rare",
            cost: 4,
            attack: 3,
            health: 5,
            text: "Card text goes here",
            flavor: "Flavor text goes here",
            artist: "Artist Name",
            collectible: true,
            elite: false,
            playerClass: "Mage",
            howToGetSignature: "How to obtain the card signature",
            img: "card-image-url",
            locale: "en_US",
            mechanics: [Mechanic(name: "Mechanic 1"), Mechanic(name: "Mechanic 2")]
        )

        return card
    }

}

extension Card: Equatable {
    public static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.cardId == rhs.cardId
    }
}

class MockServiceAPI: ServiceAPIProtocol {
    var result: Any?
    var error: Error?

    func fetch<T: Decodable>(from endpoint: String) async throws -> T {
        if let error = error {
            throw error
        }

        guard let result = result as? T else {
            fatalError("Couldn't cast mock result to \(T.self). Please set the correct type in mock.")
        }

        return result
    }
}
