//
//  NetworkTests.swift
//  WordieTests
//
//  Created by Ilia Gutu on 1/28/21.
//

import XCTest
@testable import Wordie

class NetworkTests: XCTestCase {

    var network: Network!
    var urlSession: MockURLSession!

    override func setUp() {
        super.setUp()
        urlSession = MockURLSession()
        network = Network(session: urlSession)
    }

    func test_dataTask_whenSucceeded_shouldReturnData() {
        //GIVEN
        let expectedResponse = HTTPURLResponse.mocked(status: 200)
        urlSession.dataTaskStub = (Data(), expectedResponse, nil)
        let expectation = self.expectation(description: "lookupCall")
        var requestFailed = false
        var error: SkyError?

        //WHEN
        _ = network.dataTask(with: URLRequest(url: .mocked())) { result in
            switch result {
            case .success:
                requestFailed = false
            case .failure(let failure):
                error = failure
                requestFailed = true
            }
            expectation.fulfill()
        }
        //THEN
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(requestFailed)
        XCTAssertNil(error)
    }

    func test_dataTask_whenFailed_shouldReturnCorrespondingError() {
        //GIVEN
        let expectedError = SkyError.badResponse
        urlSession.dataTaskStub = (nil, nil, expectedError)
        let expectation = self.expectation(description: "lookupCall")
        var requestFailed = true
        var error: SkyError?

        //WHEN
        _ = network.dataTask(with: URLRequest(url: .mocked())) { result in
            switch result {
            case .success:
                requestFailed = false
            case .failure(let failure):
                requestFailed = true
                error = failure
            }
            expectation.fulfill()
        }

        //THEN
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(requestFailed)
        XCTAssert(error == expectedError)
    }
}
