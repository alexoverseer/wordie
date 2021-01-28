//
//  DetailFlowCoordinator.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import Foundation

protocol DetailFlowCoordinatorInput { }

class DetailFlowCoordinator: BaseCoordinator {
    private let wireframe: Wireframe
    private let item: Word

    init(item: Word, wireframe: Wireframe) {
        self.wireframe = wireframe
        self.item = item
        super.init()
    }

    override func start() {
        let viewController = DetailScreenBuilder.build(item)
        wireframe.push(viewController)
    }
}

extension DetailFlowCoordinator: DetailFlowCoordinatorInput { }
