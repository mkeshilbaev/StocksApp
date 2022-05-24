//
//  StocksViewController.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 23.05.2022.
//

import UIKit

class StocksViewController: UIViewController {

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
	}

	private func setupSubviews(){
		view.addSubview(tableView)
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
}



extension StocksViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell

		return cell
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
}



extension NSObject{
	static var typeName: String{
		String(describing: self)
	}
}

