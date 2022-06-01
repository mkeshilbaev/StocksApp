//
//  StocksDetailPresenter.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 30.05.2022.
//

import Foundation

protocol StocksDetailViewProtocol: AnyObject {
	func updateView()
	func updateView(withLoader isLoading: Bool)
	func updateView(withError message: String)
}

protocol StocksDetailPresenterProtocol {
	var view: StocksDetailViewProtocol? { get set }

	func loadView()
	func model(for indexPath: IndexPath) -> StockDetailModelProtocol
}

final class StocksDetailPresenter: StocksDetailPresenterProtocol {
	private let service: StocksDetailServiceProtocol
	private var stockDetails: [StockDetailModelProtocol] = []

	init(service: StocksDetailServiceProtocol) {
		self.service = service
	}

	weak var view: StocksDetailViewProtocol?

	func loadView() {
		// идем в сеть и показываем лоадер
		view?.updateView(withLoader: true)

		service.getStocksDetail { [weak self] result in
			// возвращаемся с данными и убираем лоадер
			self?.view?.updateView(withLoader: false)

			switch result {
			case .success(let stockDetails):
				self?.stockDetails = stockDetails.map { StockDetailModel(stockDetail: $0)}
				self?.view?.updateView()
			case .failure(let error):
				self?.view?.updateView(withError: error.localizedDescription)
			}
		}
	}

	func model(for indexPath: IndexPath) -> StockDetailModelProtocol {
		stockDetails[indexPath.row]
	}
}
