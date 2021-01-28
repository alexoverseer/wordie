//
//  URLSession.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/25/21.
//
import Foundation

protocol URLSessionType {
    func dataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> Task
}

extension URLSession: URLSessionType {
    func dataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> Task {
        return dataTask(with: request, completionHandler: completion)
    }
}
