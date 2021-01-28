//
//  CellModel.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import Foundation

public protocol CellModel {
    var identifier: String { get }
    var data: CellData { get }
    init(data: CellData)
}

public protocol CellData { }

public protocol PopulatableCell {
    func populate(with data: CellData)
}
