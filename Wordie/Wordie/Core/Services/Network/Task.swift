//
//  Task.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/27/21.
//

import Foundation

protocol Task {
    func resume()
    func cancel()
}

extension URLSessionTask: Task {}
