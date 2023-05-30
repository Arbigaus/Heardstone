//
//  URLSessionMock.swift
//  HeardstoneTests
//
//  Created by Gerson Arbigaus on 29/05/23.
//

import Foundation
@testable import Heardstone

class URLSessionMock: URLSessionProtocol {
    var nextData: Data?
    var nextError: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = nextError {
            throw error
        }
        return (nextData ?? Data(), HTTPURLResponse())
    }
}
