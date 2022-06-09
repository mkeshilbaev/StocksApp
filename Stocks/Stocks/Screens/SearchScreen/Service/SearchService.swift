//
//  SearchService.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 09.06.2022.
//

import Foundation

protocol SearchServiceProtocol {
	func getStocks(currency: String, count: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void)
}

final class SearchService: SearchServiceProtocol {
	private let network: NetworkService
	private var stocks: [StockModelProtocol] = []

	init(network: NetworkService) {
		self.network = network
	}

	func getStocks(currency: String, count: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void) {
		if stocks.isEmpty {
			fetch(currency: currency, count: count, completion: completion)
			return
		}

		completion(.success(stocks))
	}

	func fetch(currency: String, count: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void){
		network.execute(with: StockRouter.stocks(currency: currency, count: count)) { [weak self] (result: Result<[Stock], NetworkError>) in
			guard let self = self else { return }
			switch result {
			case .success(let stocks):
				completion(.success(self.stockModels(for: stocks)))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

	private func stockModels(for stocks: [Stock]) -> [StockModelProtocol] {
		stocks.map { StockModel(stock: $0) }
	}
}
