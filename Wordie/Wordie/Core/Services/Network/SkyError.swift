//
//  SkyError.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/25/21.
//

import Foundation

enum SkyError: Error, Equatable {
    static func == (lhs: SkyError, rhs: SkyError) -> Bool {
        switch (lhs, rhs) {
        case (.badResponse, .badResponse):
            return true
        case (.nonHTTPResponse, .nonHTTPResponse):
            return true
        case (.badStatusCode(let lhsCode), .badStatusCode(let rhsCode)):
            return lhsCode == rhsCode
        case (.failure(let lhsError), .failure(let rhsError)):
            return lhsError?.localizedDescription == rhsError?.localizedDescription
        default:
            return false
        }
    }

    case invalidURL(_ url: String)
    case badResponse
    case nonHTTPResponse
    case badStatusCode(_ code: Int)
    case failure(_ error: Error?)

    var localizedDescription: String {
        switch self {
        case .badResponse:
            return "Bad response"
        case .nonHTTPResponse:
            return "Non HTTP response"
        case .badStatusCode(let statusCode):
            return "Status code \(statusCode) didn't fall within the given range."
        case .failure(let error):
            return error?.localizedDescription ?? "Something went wrong."
        case .invalidURL(let url):
            return "Provided url \(url) seems to be invalid"
        }
    }

    init(error: Error?) {
        if let skyError = error as? SkyError {
            self = skyError
        } else {
            self = .failure(error)
        }
    }
}
