//
//  Card.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 29/05/23.
//

import Foundation

struct Card: Decodable {
    let cardId: String
    let name: String
    let cardSet: String
    let type: String
    let faction: String
    let rarity: String
    let cost: Int
    let attack: Int
    let health: Int
    let text: String
    let flavor: String
    let artist: String
    let collectible: Bool
    let elite: Bool
    let race: String
    let img: URL
    let imgGold: URL
    let locale: String
}
