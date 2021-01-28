//
//  SearchFlowInteractor.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/27/21.
//

import Foundation

final class SearchFlowInteractor: SearchFlowInteractorType {

    weak var output: SearchFlowInteractorOutput?
    private let lookupService: LookupServiceType
    private var words: [Word] = []
    var coordinator: SearchFlowCoordinatorInput?

    init(lookupService: LookupServiceType) {
        self.lookupService = lookupService
    }

    func lookupItems(by query: String?) {
        output?.showHUD()
        lookupService.lookup(query: .init(query: query)) { [weak self] result in
            self?.output?.hideHUD()
            switch result {
            case .success(let words):
                self?.words = words
                self?.output?.didFinishLoadingItems()
            case .failure(let error):
                print(error.localizedDescription)
                self?.output?.didFail(with: error)
            }
        }
    }

    func cellModel(at indexPath: IndexPath) -> CellModel? {
        let item = words[indexPath.row]
        return WordCellViewModel(data: TextCellModel(title: item.text, subtitle: item.translations))
    }

    var itemsCount: Int {
        return words.count
    }

    func didSelectItem(at indexPath: IndexPath) {
        let item = words[indexPath.row]
        coordinator?.didSelect(item)
    }
}
