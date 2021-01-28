//
//  Identifiable.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//
import UIKit

public protocol Identifiable {
    static var identifier: String { get }
}

public extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {

    public func register<T: UITableViewCell & Identifiable>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: type.identifier)
    }

    public func dequeue<R: Identifiable>(for indexPath: IndexPath) -> R {
        return dequeue(R.self, for: indexPath)
    }

    public func dequeue<R: Identifiable>(_ type: R.Type, for indexPath: IndexPath) -> R {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! R
    }
}
