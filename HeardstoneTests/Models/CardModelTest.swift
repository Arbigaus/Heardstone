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

        let card = Card(cardId: "123",
                        name: "SampleCard",
                        cardSet: "SampleSet",
                        type: "SampleType",
                        faction: "SampleFaction",
                        rarity: "SampleRarity",
                        cost: 1,
                        attack: 1,
                        health: 1,
                        text: "SampleText",
                        flavor: "SampleFlavor",
                        artist: "SampleArtist",
                        collectible: true,
                        elite: false,
                        race: "SampleRace",
                        img: sampleURL,
                        imgGold: sampleURL,
                        locale: "en_US")

        return card
    }

}

extension Card: Equatable {
    public static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.cardId == rhs.cardId &&
        lhs.name == rhs.name &&
        lhs.cardSet == rhs.cardSet &&
        lhs.type == rhs.type &&
        lhs.faction == rhs.faction &&
        lhs.rarity == rhs.rarity &&
        lhs.cost == rhs.cost &&
        lhs.attack == rhs.attack &&
        lhs.health == rhs.health &&
        lhs.text == rhs.text &&
        lhs.flavor == rhs.flavor &&
        lhs.artist == rhs.artist &&
        lhs.collectible == rhs.collectible &&
        lhs.elite == rhs.elite &&
        lhs.race == rhs.race &&
        lhs.img == rhs.img &&
        lhs.imgGold == rhs.imgGold &&
        lhs.locale == rhs.locale
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