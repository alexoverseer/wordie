//
//  DetailFlow.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/27/21.
//

import UIKit

protocol DetailFlowInteractorType {
    func viewDidLoad()
    var title: String { get }
    func cellModel(at indexPath: IndexPath) -> CellModel?
    var itemsCount: Int { get }
    func didSelectItem(at indexPath: IndexPath)
}

protocol DetailFlowInteractorOutput: class, HUDPresentable {
    func didFinishLoadingItems()
    func didFail(with error: SkyError)
}

enum DetailScreenBuilder {

    static func build(_ item: Word, lookupService: LookupServiceType = AppEnvironment.lookupService) -> UIViewController {
        let interactor = DetailFlowInteractor(item: item, lookupService: lookupService)
        let viewController = WordDetailViewController()
        viewController.interactor = interactor
        interactor.output = viewController
        return viewController
    }
}
