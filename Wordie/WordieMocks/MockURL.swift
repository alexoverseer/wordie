//
//  MockURL.swift
//  WordieTests
//
//  Created by Ilia Gutu on 1/28/21.
//

import Foundation

extension URL {
    static func mocked(path: String =  "www.skyeng.ru") -> URL {
        return URL(string: path)!
    }
}
