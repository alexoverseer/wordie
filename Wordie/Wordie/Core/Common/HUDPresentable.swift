//
//  HUDPresentable.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/27/21.
//

import UIKit

protocol HUDPresentable {
    func showHUD()
    func hideHUD()
}

extension UIViewController: HUDPresentable {
    func showHUD() {
        UI { [weak self] in self?.addSpinnerController() }
    }

    func hideHUD() {
        UI { [weak self] in self?.hideSpinnerController() }
    }

    private func addSpinnerController() {
        if children.first(where: { $0 is LoadingViewController }) != nil { return }
        let child = LoadingViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    private func hideSpinnerController() {
        guard let child = children.first(where: { $0 is LoadingViewController }) else { return }
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
