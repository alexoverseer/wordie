//
//  SearchViewController.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/27/21.
//

import UIKit

final class SearchViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)
    var results: [WordItemViewModel] = []
    var interactor: SearchFlowInteractorInput!
    private var failureMessage: String?
    var coordinator: SearchFlowCoordinatorInput?

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WordTableViewCell.self, forCellReuseIdentifier: String(describing: WordTableViewCell.self))
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
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
        results.isEmpty ? tableView.setEmptyView(title: Localizable.Search.emptyViewTitle, message: failureMessage ?? Localizable.Search.emptyViewSubtitle) : tableView.restore()
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WordTableViewCell.self), for: indexPath)
        let element = results[indexPath.row]
        cell.textLabel?.text = element.title
        cell.detailTextLabel?.text = element.subtitle
        return cell
    }
}

extension SearchViewController: SearchFlowInteractorOutput {
    func didFinishLoading(items: [WordItemViewModel]) {
        results = items
        failureMessage = nil
        UI { [weak self] in self?.tableView.reloadData() }
    }

    func didFail(with error: SkyError) {
        failureMessage = error.localizedDescription
        reloadData(with: [])
    }

    private func reloadData(with items: [WordItemViewModel]) {
        results = items
        UI { [weak self] in self?.tableView.reloadData() }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = results[indexPath.row]
        coordinator?.didSelect(item.item)
    }
}
