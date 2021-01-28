//
//  AppEnvironment.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/25/21.
//

import Foundation

struct AppEnvironment {

    fileprivate static var stack: [Environment] = [.current]

    public static var current: Environment! {
        return stack.last
    }

    public static func replaceCurrentEnvironment(_ env: Environment) {
        self.pushEnvironment(env)
    }

    public static func pushEnvironment(_ env: Environment) {
        self.stack.insert(env, at: 0)
    }
}

extension AppEnvironment {

    public static var lookupService: LookupServiceType {
        return current.services.lookupService
    }
}
