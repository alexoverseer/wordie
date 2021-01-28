//
//  MockResponse.swift
//  WordieTests
//
//  Created by Ilia Gutu on 1/28/21.
//

import Foundation
extension HTTPURLResponse {
    static func mocked(status: Int, url: URL = .mocked()) -> HTTPURLResponse? {
        return HTTPURLResponse(url: url, statusCode: status, httpVersion: nil, headerFields: nil)
    }
}
