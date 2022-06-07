//
//  StocksViewController.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 23.05.2022.
//

import UIKit

final class StocksViewController: UIViewController {
	private let presenter: StocksPresenterProtocol
	
	init(presenter: StocksPresenterProtocol) {
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
		setupSubviews()
		
		presenter.loadView()
	}
	
	private func setupViews(){
		view.backgroundColor = .white
		title = "Stocks"
		navigationItem.largeTitleDisplayMode = .always
		navigationController?.navigationBar.prefersLargeTitles = true
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

extension StocksViewController: StocksViewProtocol {
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

extension StocksViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as? StockCell else {
			return UITableViewCell()
		}
		cell.configure(with: presenter.model(for: indexPath), for: indexPath)
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.itemsCount
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		76
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let model = presenter.model(for: indexPath)
		let detailVC = Assembly.assembler.detailVC(model: model)
		navigationController?.pushViewController(detailVC, animated: true)
	}
}





