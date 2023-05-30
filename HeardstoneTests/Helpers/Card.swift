//
//  Card.swift
//  HeardstoneTests
//
//  Created by Gerson Arbigaus on 29/05/23.
//

import Foundation

struct Card: Decodable {
    let cardId: String
    let name: String
    let cardSet: String
    let type: String
    let rarity: String
}
