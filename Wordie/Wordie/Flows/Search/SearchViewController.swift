//
//  SearchViewController.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/27/21.
//

import UIKit

final class SearchViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)
    var interactor: SearchFlowInteractorType!
    private var failureMessage: String?

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WordTableViewCell.self)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchContainer()
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.pinToEdges(of: view)
    }

    private func setupSearchContainer() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Localizable.Search.searchBarPlaceholder
        navigationItem.searchController = searchController
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        interactor.lookupItems(by: searchBar.text)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor.itemsCount == 0 ? tableView.setEmptyView(title: Localizable.Search.emptyViewTitle, message: failureMessage ?? Localizable.Search.emptyViewSubtitle) : tableView.restore()
        return interactor.itemsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = interactor.cellModel(at: indexPath) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath)
        (cell as? PopulatableCell)?.populate(with: cellModel.data)
        return cell
    }
}

extension SearchViewController: SearchFlowInteractorOutput {
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

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didSelectItem(at: indexPath)
    }
}
