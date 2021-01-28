//
//  DetailFlowInteractor.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/25/21.
//

import Foundation
import AVFoundation

final class DetailFlowInteractor: DetailFlowInteractorType {

    weak var output: DetailFlowInteractorOutput?
    private let lookupService: LookupServiceType
    private let item: Word
    private var meanings: [Meanings] = []
    private var cellModels: [CellModel] = []
    private var player: AVPlayer?

    init(item: Word, lookupService: LookupServiceType) {
        self.lookupService = lookupService
        self.item = item
    }

    var title: String { item.text }

    func viewDidLoad() {
        reloadData()
    }

    func cellModel(at indexPath: IndexPath) -> CellModel? {
        return cellModels[indexPath.row]
    }

    var itemsCount: Int {
        return cellModels.count
    }

    func didSelectItem(at indexPath: IndexPath) {

    }

    private func reloadData() {
        output?.showHUD()
        let meanings = item.meanings.map { "\($0.id)" }
        lookupService.lookupMeanings(query: .init(meanings: meanings)) { [weak self] result in
            guard let `self` = self else { return }
            self.output?.hideHUD()
            switch result {
            case .success(let meanings):
                self.meanings = meanings
                self.generateCellModels(from: meanings)
                self.output?.didFinishLoadingItems()
            case .failure(let error):
                print(error.localizedDescription)
                self.output?.didFail(with: error)
            }
        }
    }

    private func generateCellModels(from data: [Meanings]) {
        let cellModels = data.compactMap { meaningCellModel(with: $0) }.flatMap { $0 }
        self.cellModels = cellModels
    }

    private func meaningCellModel(with data: Meanings) -> [CellModel] {
        var cellModels: [CellModel] = [TopImageBannerCellModel(data: data), WordCellViewModel(data: TextCellModel(title: data.transcription, subtitle: data.definition?.text))]
        if let mnemonics = data.mnemonics {
            cellModels.append(WordCellViewModel(data: TextCellModel(title: mnemonics)))
        }
        let examples = data.examples.map { AudioCellModel(data: AudioCellModelData(audioURL: $0.soundURL.asSchemedURL(), text: $0.text) { [weak self] in
            self?.playMedia($0)
        }) }
        return cellModels + examples
    }

    private func playMedia(_ url: URL?) {
        guard let url = url else { return }
        let playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: playerItem)
        player?.volume = 1.0
        player?.play()
    }
}
