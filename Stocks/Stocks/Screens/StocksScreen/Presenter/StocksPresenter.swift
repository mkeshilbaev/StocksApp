//
//  StocksPresenter.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 29.05.2022.
//

import Foundation

protocol StocksViewProtocol: AnyObject {
	func updateView()
	func updateView(withLoader isLoading: Bool)
	func updateView(withError message: String)
}

protocol StocksPresenterProtocol {
	var view: StocksViewProtocol? { get set }
	var itemsCount: Int { get }

	func loadView()
	func model(for indexPath: IndexPath) -> StockModelProtocol
}

final class StocksPresenter: StocksPresenterProtocol {
	private let service: StocksServiceProtocol
	private var stocks: [StockModelProtocol] = []
	var itemsCount: Int { stocks.count }

	init(service: StocksServiceProtocol) {
		self.service = service
	}

	weak var view: StocksViewProtocol?

	func loadView() {
		// идем в сеть и показываем лоадер
		view?.updateView(withLoader: true)

		service.getStocks { [weak self] result in
			// возвращаемся с данными и убираем лоадер
			self?.view?.updateView(withLoader: false)

			switch result {
			case .success(let stocks):
				self?.stocks = stocks.map { StockModel(stock: $0)}
				self?.view?.updateView()
			case .failure(let error):
				self?.view?.updateView(withError: error.localizedDescription)
			}
		}
	}

	func model(for indexPath: IndexPath) -> StockModelProtocol {
		stocks[indexPath.row]
	}
}
