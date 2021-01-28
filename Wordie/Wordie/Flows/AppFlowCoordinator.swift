//
//  AppCoordinator.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import UIKit

class AppFlowCoordinator: BaseCoordinator {

    private let window: UIWindow
    private let navigationController = UINavigationController()
    lazy var wireframe = DefaultWireframe(rootController: navigationController)

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    override func start() {
        runMainFlow()
    }

    private func runMainFlow() {
        let flowCoordinator = SearchFlowCoordinator(wireframe: wireframe)

        addChild(flowCoordinator)
        flowCoordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        flowCoordinator.isCompleted = { [weak self] in
            self?.remove(flowCoordinator)
        }
    }
}
