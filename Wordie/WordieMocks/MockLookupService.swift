//
//  MockLookupService.swift
//  WordieTests
//
//  Created by Ilia Gutu on 1/28/21.
//

import Foundation
@testable import Wordie

final class MockLookupService: LookupServiceType {

    private (set) var lastQuery: LookupQuery?
    var responseStub: Result<[Word], SkyError> = .failure(.badResponse)

    func lookup(query: LookupQuery, completion: @escaping (Result<[Word], SkyError>) -> Void) {
        lastQuery = query
        completion(responseStub)
    }
}
