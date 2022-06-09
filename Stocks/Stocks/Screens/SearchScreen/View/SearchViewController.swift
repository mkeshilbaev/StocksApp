//
//  SearchViewController.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 08.06.2022.
//

import UIKit

class SearchViewController: UITableViewController {
	private let presenter: StocksPresenterProtocol

	init(presenter: StocksPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private var stocks = [StockModel]()
	private var filteredStocks = [StockModel]()

	private let searchController = UISearchController(searchResultsController: nil)

	private var searchBarIsEmpty: Bool {
		guard let text = searchController.searchBar.text else { return false }
		return text.isEmpty
	}

	private var isFiltering: Bool {
		return searchController.isActive && !searchBarIsEmpty
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupViews()
		setupSearchController()
	}

	private func setupViews(){
		view.backgroundColor = .white
		title = "Search"
		navigationItem.largeTitleDisplayMode = .always
		navigationController?.navigationBar.prefersLargeTitles = true
	}

	private func setupSearchController(){
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search"
		navigationItem.searchController = searchController
		definesPresentationContext = true
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isFiltering {
			return filteredStocks.count
		}
		return 0
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as? StockCell else {
			return UITableViewCell()
		}
		cell.configure(with: presenter.model(for: indexPath), for: indexPath)
		return cell
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		76
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let model = presenter.model(for: indexPath)
		let detailVC = Assembly.assembler.detailVC(model: model)
		navigationController?.pushViewController(detailVC, animated: true)
	}
}


// MARK: - UISearchResultsUpdating Delegate
extension SearchViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		filterContentForSearchText(searchController.searchBar.text!)
	}

	private func filterContentForSearchText(_ searchText: String) {
		filteredStocks = stocks.filter({ (stock: StockModel) -> Bool in
			return stock.name.lowercased().contains(searchText.lowercased())
		})

		tableView.reloadData()
	}
}
