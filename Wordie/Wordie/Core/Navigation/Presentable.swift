//
//  Presentable.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import UIKit

protocol Presentable {
  func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {

  func toPresent() -> UIViewController? {
    return self
  }
}
