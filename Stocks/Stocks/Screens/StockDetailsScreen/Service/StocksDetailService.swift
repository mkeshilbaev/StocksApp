//
//  StocksDetailService.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 30.05.2022.
//

import Foundation

protocol StocksDetailServiceProtocol{
	func getStocksDetail(coin: String, currency: String, days: String, interval: String, completion: @escaping (Result<[StocksDetail], NetworkError>) -> Void)
	func getStocksDetail(completion: @escaping (Result<[StocksDetail], NetworkError>) -> Void)
}

final class StocksDetailService: StocksDetailServiceProtocol {
	private let client: NetworkService

	init(client: NetworkService) {
		self.client = client
	}

	func getStocksDetail(coin: String, currency: String, days: String, interval: String, completion: @escaping (Result<[StocksDetail], NetworkError>) -> Void) {
		client.execute(with: StocksDetailRouter.stockDetails(coin: coin, currency: currency, days: days, interval: interval), completion: completion)
	}
}

extension StocksDetailServiceProtocol {
	func getStocksDetail(completion: @escaping (Result<[StocksDetail], NetworkError>) -> Void){
		getStocksDetail(completion: completion)
	}
}
