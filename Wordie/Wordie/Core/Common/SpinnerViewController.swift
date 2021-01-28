//
//  SpinnerViewController.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import UIKit

class SpinnerViewController: UIViewController {

    lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.startAnimating()
        return activityView
    }()

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.addSubview(activityView)
        activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
