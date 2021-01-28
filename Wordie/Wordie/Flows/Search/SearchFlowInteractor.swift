//
//  SearchFlowInteractor.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/27/21.
//

import Foundation

final class SearchFlowInteractor: SearchFlowInteractorInput {

    weak var output: SearchFlowInteractorOutput?
    private let lookupService: LookupServiceType

    init(lookupService: LookupServiceType) {
        self.lookupService = lookupService
    }

    func lookupItems(by query: String?) {
        output?.showHUD()
        lookupService.lookup(query: .init(query: query)) { [weak self] result in
            self?.output?.hideHUD()
            switch result {
            case .success(let words):
                self?.output?.didFinishLoading(items: words.map { WordItemViewModel(item: $0) })
            case .failure(let error):
                print(error.localizedDescription)
                self?.output?.didFail(with: error)
            }
        }
    }
}
