//
//  StocksViewController.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 23.05.2022.
//

import UIKit

final class StocksViewController: UIViewController {

	private var stocks: [Stock] = []

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorStyle = .none
		tableView.register(StockCell.self, forCellReuseIdentifier: String(describing: StockCell.typeName))
		return tableView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupSubviews()
		view.backgroundColor = .white

		tableView.dataSource = self
		tableView.delegate = self

		getStocks()
	}

	private func setupSubviews(){
		view.addSubview(tableView)
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}

	private func getStocks(){
		let client = Network()
		let service: StocksServiceProtocol = StocksService(client: client)

		service.getStocks { [weak self] result in
			switch result {
			case .success(let stocks):
				self?.stocks = stocks
				self?.tableView.reloadData()
			case .failure(let error):
				self?.showError(error.localizedDescription)
			}
		}
	}

	private func showError(_ message: String){
		print(message)
	}
}

extension StocksViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as? StockCell else {
			return UITableViewCell()
		}
		cell.configure(with: stocks[indexPath.row], for: indexPath)
		return cell
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return stocks.count
	}
}

extension StocksViewController: UITableViewDelegate{
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		76
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailVC = DetailsViewController()
		let navigationController = UINavigationController(rootViewController: detailVC)
		navigationController.modalPresentationStyle = .fullScreen
		present(navigationController, animated: true)
	}
}

extension NSObject{
	static var typeName: String{
		String(describing: self)
	}
}



