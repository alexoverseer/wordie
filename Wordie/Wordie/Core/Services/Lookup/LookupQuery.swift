//
//  LookupQuery.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/25/21.
//

import Foundation

struct LookupQuery {
    let query: String?
    let meanings: [String]?

    init(query: String? = nil, meanings: [String] = []) {
        self.query = query
        self.meanings = meanings
    }
}
