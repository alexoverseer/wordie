//
//  WordDetailViewController.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import UIKit

class WordDetailViewController: UIViewController {
    var interactor: DetailFlowInteractorInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = interactor.title
        view.backgroundColor = .white
    }
}

extension WordDetailViewController: DetailFlowInteractorOutput {
    func didFinishLoading(items: [WordItemViewModel]) {

    }

    func didFail(with error: SkyError) {

    }
}
