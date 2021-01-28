//
//  Services.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/26/21.
//

import Foundation

struct Services {

    let lookupService: LookupServiceType

    init(network: NetworkType) {
        lookupService = LookupService(network: network)
    }
}
