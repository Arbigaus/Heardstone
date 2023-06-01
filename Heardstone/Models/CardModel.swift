//
//  CardModel.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 29/05/23.
//

import Foundation

protocol CardModelProtocol {
    func fetchCardList(setName: String) async throws -> [Card]
}

final class CardModel: CardModelProtocol {
    let service: ServiceAPIProtocol

    init(service: ServiceAPIProtocol = ServiceAPI()) {
        self.service = service
    }

    func fetchCardList(setName: String) async throws -> [Card] {
        do {
            let validURLString: String = setName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let list: [Card] = try await service.fetch(from: "cards/sets/\(validURLString)")
            return list

        } catch(let error) {
            print(error.localizedDescription)
            return []
        }

    }
}
