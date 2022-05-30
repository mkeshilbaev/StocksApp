//
//  StocksService.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 26.05.2022.
//

import Foundation

protocol StocksServiceProtocol{
	func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
	func getStocks(currency: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
	func getStocks(completion: @escaping (Result<[Stock], NetworkError>) -> Void)
}

final class StocksService: StocksServiceProtocol {
	private let client: NetworkService

	init(client: NetworkService) {
		self.client = client
	}

	func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
		client.execute(with: StockRouter.stocks(currency: currency, count: count), completion: completion)
	}
}

extension StocksServiceProtocol{
	func getStocks(currency: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void){
		getStocks(currency: currency, count: "100", completion: completion)
	}

	func getStocks(completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
		getStocks(currency: "usd", completion: completion)
	}
}
