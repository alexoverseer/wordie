//
//  BaseCoordinator.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import Foundation

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var isCompleted: (() -> Void)?

    func start() {
        fatalError("Children should implement `start`.")
    }
}
