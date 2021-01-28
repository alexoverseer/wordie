//
//  AudioCellData.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import Foundation

protocol AudioCellData: CellData {
    var audioURL: URL? { get }
    var text: String? { get }
    var onButtonTapped: ((URL?) -> Void)? { get }
}

struct AudioCellModelData: AudioCellData {
    let audioURL: URL?
    let text: String?
    let onButtonTapped: ((URL?) -> Void)?

    init(audioURL: URL? = nil, text: String? = nil, onButtonTapped: ((URL?) -> Void)? = nil) {
        self.audioURL = audioURL
        self.text = text
        self.onButtonTapped = onButtonTapped
    }
}

struct AudioCellModel: CellModel {
    var identifier = AudioDataTableViewCell.identifier

    var data: CellData

    init(data: CellData) {
        self.data = data
    }
}
