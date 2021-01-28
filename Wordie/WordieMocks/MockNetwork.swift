//
//  MockNetwork.swift
//  WordieTests
//
//  Created by Ilia Gutu on 1/27/21.
//

import Foundation
@testable import Wordie

final class MockNetwork: NetworkType {

    var nextURLTask = MockURLSessionDataTask()
    var dataTaskStub: Result<Data, SkyError> = .failure(.badResponse)

    private (set) var lastURL: URL?
    func dataTask(with request: URLRequest, completion: @escaping Completion<Data>) -> Task {
        lastURL = request.url
        completion(dataTaskStub)
        return nextURLTask
    }

    private (set) var lastEndpoint: Endpoint?
    func dataTask(to endpoint: Endpoint, completion: @escaping Completion<Data>) -> Task? {
        lastEndpoint = endpoint
        completion(dataTaskStub)
        return nextURLTask
    }

}
