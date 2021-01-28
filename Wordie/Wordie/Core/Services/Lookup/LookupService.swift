//
//  LookupService.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/25/21.
//

import Foundation

protocol LookupServiceType {
    func lookup(query: LookupQuery, completion: @escaping (Result<[Word], SkyError>) -> Void)
    func lookupMeanings(query: LookupQuery, completion: @escaping (Result<[Meanings], SkyError>) -> Void)
}

final class LookupService: LookupServiceType {
    private let network: NetworkType
    private var lastExecutedTask: Task?

    init(network: NetworkType) {
        self.network = network
    }

    func lookup(query: LookupQuery, completion: @escaping (Result<[Word], SkyError>) -> Void) {
        lastExecutedTask?.cancel()
        lastExecutedTask = network.dataTask(to: LookupServiceEndpoints.lookup(query: query.query)) { result in
            switch result {
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode([Word].self, from: data)
                    completion(.success(results))
                } catch {
                    completion(.failure(SkyError(error: error)))
                }
            case .failure(let error):
                completion(.failure(SkyError(error: error)))
            }
        }
        lastExecutedTask?.resume()
    }

    func lookupMeanings(query: LookupQuery, completion: @escaping (Result<[Meanings], SkyError>) -> Void) {
        lastExecutedTask?.cancel()
        lastExecutedTask = network.dataTask(to: LookupServiceEndpoints.meanings(query.meanings)) { result in
            switch result {
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode([Meanings].self, from: data)
                    completion(.success(results))
                } catch {
                    completion(.failure(SkyError(error: error)))
                }
            case .failure(let error):
                completion(.failure(SkyError(error: error)))
            }
        }
        lastExecutedTask?.resume()
    }
}
