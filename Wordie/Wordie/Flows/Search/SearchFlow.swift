//
//  SearchFlow.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/27/21.
//

import UIKit

protocol SearchFlowInteractorInput {
    func lookupItems(by query: String?)
}

protocol SearchFlowInteractorOutput: class, HUDPresentable {
    func didFinishLoading(items: [WordItemViewModel])
    func didFail(with error: SkyError)
}

enum SearchScreenBuilder {
    static func build(lookupService: LookupServiceType = AppEnvironment.lookupService) -> SearchViewController {
        let viewController = SearchViewController()
        let interactor = SearchFlowInteractor(lookupService: lookupService)
        viewController.interactor = interactor
        interactor.output = viewController
        return viewController
    }
}
