//
//  ItemDescriptionTableViewCell.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import UIKit

final class ItemDescriptionTableViewCell: UITableViewCell, Identifiable, PopulatableCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        detailTextLabel?.numberOfLines = 0
    }

    func populate(with data: CellData) {
        guard let data = data as? TextCellData else { return }
        textLabel?.text = data.title
        detailTextLabel?.text = data.subtitle
    }
}
