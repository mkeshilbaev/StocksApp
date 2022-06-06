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
	var titleModel: DetailTitleView.TitleModel { get }
	var favouriteButtonIsSelected: Bool { get }
	
	func loadView()
	func favouriteButtonTapped()
}

final class StocksDetailPresenter: StocksDetailPresenterProtocol {
	private let model: StockModelProtocol
	private let service: ChartsServiceProtocol

	weak var view: StocksDetailViewProtocol?
	
	lazy var titleModel: DetailTitleView.TitleModel = {
		.from(stockModel: model)
	}()
	
	var favouriteButtonIsSelected: Bool {
		model.isFavourite
	}
	
	init(model: StockModelProtocol, service: ChartsServiceProtocol) {
		self.model = model
		self.service = service
	}
	
	func loadView() {
		view?.updateView(withLoader: true)
		service.getCharts(id: model.id) { [weak self] result in
			self?.view?.updateView(withLoader: false)
			switch result {
			case let .success(charts):
				self?.view?.updateView()
			case let .failure(error):
				self?.view?.updateView(withError: error.localizedDescription)
			}
		}
	}
	
	func favouriteButtonTapped() {
		model.setFavourite()
	}
}
