//
//  MockURLSession.swift
//  WordieTests
//
//  Created by Ilia Gutu on 1/28/21.
//

import Foundation
@testable import Wordie

final class MockURLSession: URLSessionType {

    var nextURLTask = MockURLSessionDataTask()
    var dataTaskStub: (Data?, URLResponse?, Error?) = (nil, nil, nil)

    private (set) var lastURL: URL?
    func dataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> Task {
        lastURL = request.url
        completion(dataTaskStub.0, dataTaskStub.1, dataTaskStub.2)
        return nextURLTask
    }
}
