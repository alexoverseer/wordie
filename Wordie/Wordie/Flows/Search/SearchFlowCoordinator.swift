//
//  SearchFlowCoordinator.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import UIKit

protocol SearchFlowCoordinatorInput {
    func didSelect(_ item: Word)
}

class SearchFlowCoordinator: BaseCoordinator, SearchFlowCoordinatorInput {
    private let wireframe: Wireframe
    init(wireframe: Wireframe) {
        self.wireframe = wireframe
        super.init()
    }

    override func start() {
        let viewController = SearchScreenBuilder.build(coordinator: self)
        wireframe.setRootModule(viewController)
    }

    func didSelect(_ item: Word) {
        let detailFlowCoordinator = DetailFlowCoordinator(item: item, wireframe: wireframe)
        addChild(detailFlowCoordinator)
        detailFlowCoordinator.start()
    }
}
