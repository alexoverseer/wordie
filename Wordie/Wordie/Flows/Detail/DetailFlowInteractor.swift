//
//  DetailFlowInteractor.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/25/21.
//

import Foundation

final class DetailFlowInteractor: DetailFlowInteractorInput {

    weak var output: DetailFlowInteractorOutput?
    private let lookupService: LookupServiceType
    private let item: Word

    init(item: Word, lookupService: LookupServiceType) {
        self.lookupService = lookupService
        self.item = item
    }

    var title: String { item.text }

    func viewDidLoad() {}
}
