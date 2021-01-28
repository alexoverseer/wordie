//
//  WordTableViewCell.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import UIKit

class WordTableViewCell: UITableViewCell {

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
}

struct WordItemViewModel {
    let item: Word

    init(item: Word) {
        self.item = item
    }

    var title: String {
        return item.text
    }

    var subtitle: String {
        let translations = item.meanings.map { $0.translation.text }.joined(separator: ", ")
        return translations
    }
}
