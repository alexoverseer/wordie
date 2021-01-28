//
//  TopCellData.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import Foundation

protocol TopCellData: CellData {
    var imageURL: URL? { get }
}

extension Word: TopCellData {
    var imageURL: URL? {
        guard let imageURL = images.first else { return nil }
        return imageURL.asSchemedURL()
    }
}

extension Meanings: TopCellData {
    var imageURL: URL? {
        guard let imageURL = images.first?.url else { return nil }
        return imageURL.asSchemedURL()
    }
}

struct TopImageBannerCellModel: CellModel {
    var identifier = ItemTopTableViewCell.identifier

    var data: CellData

    init(data: CellData) {
        self.data = data
    }
}
