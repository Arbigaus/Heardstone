//
//  SetsModel.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 31/05/23.
//

import Foundation

protocol SetModelProtocol {
    func fetchSetList() async throws -> [String]
}

final class SetModel: SetModelProtocol {
    let service: ServiceAPIProtocol

    init(service: ServiceAPIProtocol = ServiceAPI()) {
        self.service = service
    }

    func fetchSetList() async throws -> [String] {
        let setResponse: SetResponse = try await service.fetch(from: "info")
        return setResponse.sets.removingDuplicates.sorted()
    }
}

struct SetResponse: Decodable {
    let sets: [String]
}


