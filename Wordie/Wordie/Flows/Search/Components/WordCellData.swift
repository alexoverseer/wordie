//
//  WordCellData.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import Foundation

struct WordCellViewModel: CellModel {
    let data: CellData
    var identifier = WordTableViewCell.identifier

    init(data: CellData) {
        self.data = data
    }
}

protocol TextCellData: CellData {
    var title: String? { get }
    var subtitle: String? { get }
}

struct TextCellModel: TextCellData {
    let title: String?
    let subtitle: String?

    init(title: String? = nil, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }
}
