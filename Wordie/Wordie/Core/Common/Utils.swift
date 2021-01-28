//
//  Utils.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import Foundation

func UI(execute block: @escaping () -> Void) {
    if Thread.isMainThread { return block() }
    DispatchQueue.main.async(execute: block)
}
