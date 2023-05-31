//
//  Card.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 29/05/23.
//

import Foundation

struct Card: Codable, Identifiable {
    let cardId: String?
    let dbfId: Int?
    let name: String?
    let cardSet: String?
    let type: String?
    let rarity: String?
    let cost: Int?
    let attack: Int?
    let health: Int?
    let text: String?
    let flavor: String?
    let artist: String?
    let collectible: Bool?
    let elite: Bool?
    let playerClass: String?
    let howToGetSignature: String?
    let img: String?
    let locale: String?
    let mechanics: [Mechanic]?

    var id: String? {
        return cardId
    }

    enum CodingKeys: String, CodingKey {
        case cardId = "cardId"
        case dbfId = "dbfId"
        case name = "name"
        case cardSet = "cardSet"
        case type = "type"
        case rarity = "rarity"
        case cost = "cost"
        case attack = "attack"
        case health = "health"
        case text = "text"
        case flavor = "flavor"
        case artist = "artist"
        case collectible = "collectible"
        case elite = "elite"
        case playerClass = "playerClass"
        case howToGetSignature = "howToGetSignature"
        case img = "img"
        case locale = "locale"
        case mechanics = "mechanics"
    }
}

struct Mechanic: Codable {
    let name: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}
