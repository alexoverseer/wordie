//
//  HTTPURLResponseExtensions.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/25/21.
//

import Foundation

extension HTTPURLResponse {
    func filter<R: RangeExpression>(statusCodes: R) throws where R.Bound == Int {
        guard statusCodes.contains(statusCode) else {
            throw SkyError.badStatusCode(statusCode)
        }
    }

    func checkSuccessfulStatusCodes() throws {
        return try filter(statusCodes: 200...299)
    }
}
