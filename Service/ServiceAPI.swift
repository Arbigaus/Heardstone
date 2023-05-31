//
//  ServiceAPI.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 29/05/23.
//

import Foundation

protocol ServiceAPIProtocol {
    func fetch<T: Decodable>(from endpoint: String) async throws -> T
}

final class ServiceAPI: ServiceAPIProtocol {
    private let baseUrl: String = "https://omgvamp-hearthstone-v1.p.rapidapi.com/cards/"

    var session: URLSessionProtocol = URLSession.shared

    func fetch<T: Decodable>(from endpoint: String = "") async throws -> T {
        guard let url = URL(string: "\(baseUrl)\(endpoint)") else {
            throw(NSError(domain: "Invalid URL", code: -1))
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        request.addValue(Keys.privateKey.rawValue, forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue(Keys.privateHost.rawValue, forHTTPHeaderField: "X-RapidAPI-Host")

        do {
            let (data, response)  = try await session.data(for: request)

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                throw NSError(domain: "Response error", code: 2)
            }

            guard statusCode >= 200 && statusCode <= 204 else {
                throw NSError(domain: "Response error", code: statusCode)
            }
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch(let error) {
            throw NSError(domain: error.localizedDescription, code: error._code)
        }
    }
}

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }

/*
 {"cardId":"ETC_395","dbfId":96992,"name":"DJ Manastorm","cardSet":"Festival of Legends","type":"Minion","rarity":"Legendary","cost":10,"attack":8,"health":8,"text":"<b>Battlecry:</b> Set the Cost of spells in your hand to (0).\nAfter you cast one, the others cost (1) more.","flavor":"Do not sleep on his Tinker Town deep house set - absolutely legendary.","artist":"Konstantin Porubov","collectible":true,"elite":true,"playerClass":"Mage","howToGetSignature":"Obtainable in <i>Festival of Legends</i> card packs.","img":"https://d15f34w2p8l1cc.cloudfront.net/hearthstone/38e774abee377f13e091cec5f3479170687859936e69094ccd9bf0d452ca9bcf.png","locale":"enUS","mechanics":[{"name":"Battlecry"}]}]}
 */
