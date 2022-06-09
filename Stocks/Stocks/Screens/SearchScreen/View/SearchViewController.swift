//
//  SearchViewController.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 08.06.2022.
//

import UIKit

class SearchViewController: UIViewController {
	private let presenter: SearchPresenterProtocol
	private var filteredStocks = [StockModelProtocol]()

	init(presenter: SearchPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(StockCell.self, forCellReuseIdentifier: String(describing: StockCell.typeName))
		return tableView
	}()

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
		setupSubviews()
		setupSearchController()

		presenter.loadView()
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

	private func setupSubviews(){
		view.addSubview(tableView)

		NSLayoutConstraint.activate([
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
		tableView.topAnchor.constraint(equalTo: view.topAnchor),
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

extension SearchViewController: SearchViewProtocol {
	func updateView() {
		tableView.reloadData()
	}
	func updateCell(for indexPath: IndexPath) {
		tableView.reloadRows(at: [indexPath], with: .none)
	}
	func updateView(withLoader isLoading: Bool) {
		print("Loader is -", isLoading, " at", Date())
	}
	func updateView(withError message: String) {
		print("Error -", message)
	}
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as? StockCell else {
			return UITableViewCell()
		}
		cell.configure(with: filteredStocks[indexPath.row], for: indexPath)
		return cell
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isFiltering {
			return filteredStocks.count
		}
		return 0
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		76
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailVC = Assembly.assembler.detailVC(model: filteredStocks[indexPath.row])
		navigationController?.pushViewController(detailVC, animated: true)
	}
}

extension SearchViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		filterContentForSearchText(searchController.searchBar.text!)
	}

	private func filterContentForSearchText(_ searchText: String) {
		filteredStocks = presenter.stocksList.filter({ (stock: StockModelProtocol) -> Bool in
			return stock.name.lowercased().contains(searchText.lowercased()) || stock.symbol.lowercased().contains(searchText.lowercased())
		})
		tableView.reloadData()
	}
}
