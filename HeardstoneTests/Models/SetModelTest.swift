//
//  SetModelTest.swift
//  HeardstoneTests
//
//  Created by Gerson Arbigaus on 31/05/23.
//

import XCTest
@testable import Heardstone

final class SetModelTest: XCTestCase {

    func testFetchSetListSuccess() async throws {
        let mockServiceAPI = MockServiceAPI()
        let expectedSetList = ["set1", "set2", "set3"]
        mockServiceAPI.result = SetResponse(sets: expectedSetList)

        let setModel = SetModel(service: mockServiceAPI)
        let setList = try await setModel.fetchSetList()

        XCTAssertEqual(setList, expectedSetList, "SetList does not match expected list")
    }

    func testFetchSetListFailure() async {
        let mockServiceAPI = MockServiceAPI()
        let expectedError = NSError(domain: "test", code: 1, userInfo: nil)
        mockServiceAPI.error = expectedError

        let setModel = SetModel(service: mockServiceAPI)

        do {
            let _ = try await setModel.fetchSetList()
            XCTFail("Expected fetchSetList to throw error")
        } catch {
            XCTAssertEqual((error as NSError).domain, expectedError.domain)
        }
    }

}
