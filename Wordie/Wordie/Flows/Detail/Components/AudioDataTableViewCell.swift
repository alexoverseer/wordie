//
//  AudioDataTableViewCell.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//
import UIKit

final class AudioDataTableViewCell: UITableViewCell, Identifiable, PopulatableCell {

    lazy var playButton: UIButton = {
        let playButton = UIButton(frame: .zero)
        playButton.addTarget(self, action: #selector(didTappedButton), for: .touchUpInside)
        playButton.setImage(R.images.audioIcon, for: .normal)
        playButton.imageView?.contentMode = .scaleAspectFit
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.isUserInteractionEnabled = true
        return playButton
    }()

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    private var onButtonTapped: ((URL?) -> Void)?
    private var data: AudioCellData?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        detailTextLabel?.numberOfLines = 0
        addSubview(playButton)
        addSubview(titleLabel)

        playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        playButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true

        selectionStyle = .none
    }

    func populate(with data: CellData) {
        guard let data = data as? AudioCellData else { return }
        self.data = data
        self.onButtonTapped = data.onButtonTapped
        titleLabel.text = data.text
    }

    @objc func didTappedButton() {
        onButtonTapped?(data?.audioURL)
    }
}
