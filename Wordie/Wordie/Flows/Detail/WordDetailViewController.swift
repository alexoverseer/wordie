//
//  WordDetailViewController.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import UIKit

class WordDetailViewController: UIViewController {
    var interactor: DetailFlowInteractorType!
    private var failureMessage: String?

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WordTableViewCell.self)
        tableView.register(ItemTopTableViewCell.self)
        tableView.register(AudioDataTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        title = interactor.title
        view.backgroundColor = .white
        interactor.viewDidLoad()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.pinToEdges(of: view)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat.leastNormalMagnitude, height: CGFloat.leastNormalMagnitude))
    }
}

extension WordDetailViewController: DetailFlowInteractorOutput {
    func didFinishLoadingItems() {
        failureMessage = nil
        reloadData()
    }

    func didFail(with error: SkyError) {
        failureMessage = error.localizedDescription
        reloadData()
    }

    private func reloadData() {
        UI { [weak self] in self?.tableView.reloadData() }
    }
}

extension WordDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor.itemsCount == 0 ? tableView.setEmptyView(title: Localizable.Details.emptyViewTitle, message: failureMessage ?? Localizable.Details.emptyViewSubtitle) : tableView.restore()
        return interactor.itemsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = interactor.cellModel(at: indexPath) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath)
        (cell as? PopulatableCell)?.populate(with: cellModel.data)
        return cell
    }
}

extension WordDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didSelectItem(at: indexPath)
    }
}
