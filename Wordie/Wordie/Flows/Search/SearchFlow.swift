//
//  SearchFlow.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/27/21.
//

import UIKit

protocol SearchFlowInteractorType {
    func lookupItems(by query: String?)
    func cellModel(at indexPath: IndexPath) -> CellModel?
    var itemsCount: Int { get }
    func didSelectItem(at indexPath: IndexPath)
}

protocol SearchFlowInteractorOutput: class, HUDPresentable {
    func didFinishLoadingItems()
    func didFail(with error: SkyError)
}

enum SearchScreenBuilder {
    static func build(coordinator: SearchFlowCoordinatorInput?, lookupService: LookupServiceType = AppEnvironment.lookupService) -> SearchViewController {
        let viewController = SearchViewController()
        let interactor = SearchFlowInteractor(lookupService: lookupService)
        viewController.interactor = interactor
        interactor.coordinator = coordinator
        interactor.output = viewController
        return viewController
    }
}
