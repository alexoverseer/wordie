//
//  LookupServiceEndpoints.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/25/21.
//

import Foundation

enum LookupServiceEndpoints {
    case lookup(query: String?)
    case meanings(_ ids: [String]?)
}

extension LookupServiceEndpoints: Endpoint {

    var baseURL: URL {
        return URL(string: "https://dictionary.skyeng.ru")!
    }

    var path: String {
        switch self {
        case .lookup:
            return "/api/public/v1/words/search"
        case .meanings:
            return "/api/public/v1/meanings"
        }
    }

    var method: Method {
        switch self {
        case .lookup, .meanings:
            return .get
        }
    }

    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }

    var parameters: [String: String]? {
        switch self {
        case .lookup(let query):
            guard let query = query else { return nil }
            return ["search": query]
        case .meanings(let ids):
            guard let ids = ids else { return nil }
            return ["ids": ids.joined(separator: ",")]
        }
    }
}
