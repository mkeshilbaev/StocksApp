//
//  StocksPresenter.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 29.05.2022.
//

import Foundation

protocol StocksViewProtocol: AnyObject {
	func updateView()
	func updateCell(for indexPath: IndexPath)
	func updateView(withLoader isLoading: Bool)
	func updateView(withError message: String)
}

protocol StocksPresenterProtocol {
	var view: StocksViewProtocol? { get set }
	var itemsCount: Int { get }
	var favouriteStocksCount: Int { get }

	func loadView()
	func model(for indexPath: IndexPath) -> StockModelProtocol
	func modelFavourites(for indexPath: IndexPath) -> StockModelProtocol 
}

final class StocksPresenter: StocksPresenterProtocol {
	private let service: StocksServiceProtocol
	private var stocks: [StockModelProtocol] = []

	var itemsCount: Int {
		stocks.count
	}

	var favouriteStocksCount: Int {
		stocks.filter { $0.isFavourite }.count
	}

	init(service: StocksServiceProtocol) {
		self.service = service
		startFavoritesNotificationObserving()
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
				self?.stocks = stocks
				self?.view?.updateView()
			case .failure(let error):
				self?.view?.updateView(withError: error.localizedDescription)
			}
		}
	}

	func model(for indexPath: IndexPath) -> StockModelProtocol {
		stocks[indexPath.row]
	}

	func modelFavourites(for indexPath: IndexPath) -> StockModelProtocol {
		stocks.filter { $0.isFavourite }[indexPath.row]
	}
}

extension StocksPresenter: FavouritesUpdateServiceProtocol {
	func setFavourite(notification: Notification) {
		guard let id = notification.stockID,
			  let index = stocks.firstIndex(where: { $0.id == id }) else { return }
		let indexPath = IndexPath(row: index, section: 0)
		view?.updateCell(for: indexPath)
	}
}
