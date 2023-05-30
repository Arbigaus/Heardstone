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
        let url = URL(string: "\(baseUrl)\(endpoint)")!
        let privateKey = "Some Key"
        let privateHost = "Some private host"

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        request.addValue(privateKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue(privateHost, forHTTPHeaderField: "X-RapidAPI-Host")

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
