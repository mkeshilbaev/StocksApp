//
//  SearchPresenter.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 09.06.2022.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
	func updateView()
	func updateCell(for indexPath: IndexPath)
	func updateView(withLoader isLoading: Bool)
	func updateView(withError message: String)
}

protocol SearchPresenterProtocol {
	var view: SearchViewProtocol? { get set }
	var stocksList: [StockModelProtocol] { get }

	func loadView()
}

final class SearchPresenter: SearchPresenterProtocol {
	private let service: SearchServiceProtocol
	private var stocks: [StockModelProtocol] = []

	var stocksList: [StockModelProtocol] {
		stocks
	}

	init(service: SearchServiceProtocol) {
		self.service = service
		startFavoritesNotificationObserving()
	}

	weak var view: SearchViewProtocol?

	func loadView() {
		// идем в сеть и показываем лоадер
		view?.updateView(withLoader: true)

		service.getStocks(currency: "usd", count: "100") { [weak self] result in
			// возвращаемся с данными и убираем лоадер
			self?.view?.updateView(withLoader: false)

			switch result {
			case .success(let stocks):
				self?.stocks = stocks
				self?.view?.updateView()
			case .failure(let error):
				self?.view?.updateView(withError: error.localizedDescription)
			}
		}
	}
}

extension SearchPresenter: FavouritesUpdateServiceProtocol {
	func setFavourite(notification: Notification) {
		guard let id = notification.stockID,
			  let index = stocks.firstIndex(where: { $0.id == id }) else { return }
		let indexPath = IndexPath(row: index, section: 0)
		view?.updateCell(for: indexPath)
	}
}
