//
//  Environment.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/25/21.
//

import Foundation

public struct Environment {

    static let current = Environment()

    let services: Services
    init(network: NetworkType = Network(session: URLSession.shared)) {
        self.services = Services(network: network)
    }
}
