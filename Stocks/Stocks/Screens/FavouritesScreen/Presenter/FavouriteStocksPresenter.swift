//
//  FavouritesPresenter.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 06.06.2022.
//

import Foundation

protocol FvouriteStocksViewProtocol: AnyObject {
	func updateView()
	func updateCell(for indexPath: IndexPath)
	func updateView(withLoader isLoading: Bool)
	func updateView(withError message: String)
}

protocol FavouriteStocksPresenterProtocol {
	var view: FvouriteStocksViewProtocol? { get set }
	var favouriteStocksCount: Int { get }

	func loadView()
	func modelFavourites(for indexPath: IndexPath) -> StockModelProtocol
}

final class FavouriteStocksPresenter: FavouriteStocksPresenterProtocol {
	private let service: StocksServiceProtocol
	private var stocks: [StockModelProtocol] = []

	var favouriteStocksCount: Int {
		stocks.filter { $0.isFavourite }.count
	}

	init(service: StocksServiceProtocol) {
		self.service = service
		startFavoritesNotificationObserving()
	}

	weak var view: FvouriteStocksViewProtocol?

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

	func modelFavourites(for indexPath: IndexPath) -> StockModelProtocol {
		stocks.filter { $0.isFavourite }[indexPath.row]
	}
}

extension FavouriteStocksPresenter: FavouritesUpdateServiceProtocol {
	func setFavourite(notification: Notification) {
		guard let id = notification.stockID,
			  let index = stocks.filter({ $0.isFavourite }).firstIndex(where: { $0.id == id }) else { return }
		let indexPath = IndexPath(row: index, section: 0)
		view?.updateCell(for: indexPath)
	}
}
