//
//  Endpoint.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/25/21.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: Method { get }
    var headers: [String: String]? { get }
    var parameters: [String: String]? { get }
}

enum Method: String {
    case get = "GET"
}

extension Endpoint {
    func urlRequest() throws -> URLRequest {
        var url = baseURL.appendingPathComponent(path)
        if case .get = method {
            url = encodedWith(url: url, parameters: parameters)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }

    private func encodedWith(url: URL, parameters: [String: String]?) -> URL {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let parameters = parameters else { return url }
        let queryItems =  parameters.map { URLQueryItem(name: $0.0, value: $0.1) }
        urlComponents.queryItems = queryItems
        return urlComponents.url ?? url
    }
}
