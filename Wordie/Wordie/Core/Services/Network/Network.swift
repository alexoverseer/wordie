//
//  Network.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/25/21.
//

import Foundation

typealias Response<T> = Result<T, SkyError>
typealias Completion<T> = (Response<T>) -> Void

protocol NetworkType {
    func dataTask(with request: URLRequest, completion: @escaping Completion<Data>) -> Task
    func dataTask(to endpoint: Endpoint, completion: @escaping Completion<Data>) -> Task?
}

final class Network: NetworkType {
    private let session: URLSessionType

    init(session: URLSessionType) {
        self.session = session
    }

    func dataTask(with request: URLRequest, completion: @escaping Completion<Data>) -> Task {
        return session.dataTask(with: request) { [weak self] data, response, error in
            self?.handle(data, response: response, error: error, completion: completion)
        }
    }

    func dataTask(to endpoint: Endpoint, completion: @escaping Completion<Data>) -> Task? {
        do {
            let request = try endpoint.urlRequest()
            return session.dataTask(with: request) { [weak self] data, response, error in
                self?.handle(data, response: response, error: error, completion: completion)
            }
        } catch {
            completion(.failure(.badResponse))
            return nil
        }
    }
}

private extension Network {
    func handle<T>(_ value: T?, response: URLResponse?, error: Error?, completion: @escaping Completion<T>) {
        switch (value, response, error) {
        case (.some(let value), .some(let response), _):
            if let httpResponse = response as? HTTPURLResponse {
                do {
                    try httpResponse.checkSuccessfulStatusCodes()
                    completion(.success(value))
                } catch {
                    completion(.failure(SkyError(error: error)))
                }
            } else {
                completion(.failure(.nonHTTPResponse))
            }
        case (.none, .none, .some(let error)):
            completion(.failure(SkyError(error: error)))
        default:
            completion(.failure(.badResponse))
        }
    }
}
