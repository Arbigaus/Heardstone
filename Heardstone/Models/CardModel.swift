//
//  CardModel.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 29/05/23.
//

import Foundation

protocol CardModelProtocol {
    func fetchCardList() async throws -> [Card]
}

final class CardModel: CardModelProtocol {
    let service: ServiceAPIProtocol

    init(service: ServiceAPIProtocol = ServiceAPI()) {
        self.service = service
    }

    func fetchCardList() async throws -> [Card] {
        do {
            let list: [Card] = try await service.fetch(from: "sets/The%20Grand%20Tournament")
            return list

        } catch(let error) {
            print(error.localizedDescription)
            throw(error)
        }

    }
}
