//
//  FoundationExtensions.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import Foundation

extension String {
    func tr() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }

    func asSchemedURL() -> URL? {
        var components = URLComponents(string: deletingPrefix("//"))
        components?.scheme = "http"
        return components?.url
    }
}
