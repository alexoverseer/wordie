//
//  ItemTopTableViewCell.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//
import UIKit

final class ItemTopTableViewCell: UITableViewCell, Identifiable, PopulatableCell {

    lazy var topImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        topImage.image = R.images.placeholder
    }

    private func setupUI() {
        detailTextLabel?.numberOfLines = 0
        addSubview(topImage)
        topImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        topImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        topImage.heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        topImage.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        selectionStyle = .none
    }

    func populate(with data: CellData) {
        guard let data = data as? TopCellData else { return }
        topImage.load(url: data.imageURL!)
    }
}
