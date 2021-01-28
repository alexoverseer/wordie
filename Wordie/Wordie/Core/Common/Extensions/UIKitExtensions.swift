//
//  UIKitExtensions.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import UIKit

extension UITableView {

    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: center.x, y: center.y, width: bounds.size.width, height: bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        messageLabel.numberOfLines = 0
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)

        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.textAlignment = .center

        self.backgroundView = emptyView
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension UIView {
    func pinToEdges(of view: UIView, constant: CGFloat = 0) {
        topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: -constant).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).isActive = true
    }
}
