//
//  Card.swift
//  HeardstoneTests
//
//  Created by Gerson Arbigaus on 29/05/23.
//

import Foundation

struct CardMock: Decodable {
    let cardId: String
    let name: String
    let cardSet: String
    let type: String
    let rarity: String

    init(cardId: String, name: String, cardSet: String, type: String, rarity: String) {
        self.cardId = cardId
        self.name = name
        self.cardSet = cardSet
        self.type = type
        self.rarity = rarity
    }
}
