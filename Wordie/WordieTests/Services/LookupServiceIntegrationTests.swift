//
//  LookupServiceIntegrationTests.swift
//  WordieTests
//
//  Created by Ilia Gutu on 1/28/21.
//
import XCTest
@testable import Wordie

final class LookupServiceIntegrationTests: XCTestCase {

    var network: Network!
    var service: LookupService!

    override func setUp() {
        super.setUp()
        network = Network(session: URLSession.shared)
        service = LookupService(network: network)
    }

    func test_lookup_whenQueryIsProvided_shouldReturnSuccessfulResponse() {
        //GIVEN
        let expectation = self.expectation(description: "lookupCall")
        var responseIsNotEmpty = true
        var error: Error?

        //WHEN
        service.lookup(query: .init(query: "test")) { result in
            switch result {
            case .success(let words):
                responseIsNotEmpty = !words.isEmpty
            case .failure(let failure):
                error = failure
            }
            expectation.fulfill()
        }

        //THEN
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(responseIsNotEmpty)
        XCTAssertNil(error)
    }

    func test_detail_whenQueryIsProvided_shouldReturnSuccessfulResponse() {
        //GIVEN
        let expectation = self.expectation(description: "lookupCall")
        var responseIsNotEmpty = true
        var error: Error?

        //WHEN
        service.lookup(query: .init(query: "test")) { result in
            switch result {
            case .success(let words):
                responseIsNotEmpty = !words.isEmpty
            case .failure(let failure):
                error = failure
            }
            expectation.fulfill()
        }

        //THEN
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(responseIsNotEmpty)
        XCTAssertNil(error)
    }
}
