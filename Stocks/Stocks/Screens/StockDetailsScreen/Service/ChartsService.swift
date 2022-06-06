//
//  ChartsService.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 03.06.2022.
//

import Foundation

protocol ChartsServiceProtocol {
	func getCharts(id: String, currency: String, days: String, isDaily: Bool, completion: @escaping (Result<Charts, NetworkError>) -> Void)
	func getCharts(id: String, completion: @escaping (Result<Charts, NetworkError>) -> Void)
}

final class ChartsService: ChartsServiceProtocol {
	private let network: NetworkService
	
	init(network: NetworkService) {
		self.network = network
	}
	
	func getCharts(id: String, currency: String, days: String, isDaily: Bool, completion: @escaping (Result<Charts, NetworkError>) -> Void) {
		network.execute(with: StockRouter.charts(id: id, currency: currency, days: days, isDaily: isDaily), completion: completion)
	}
}

extension ChartsServiceProtocol {
	func getCharts(id: String, completion: @escaping (Result<Charts, NetworkError>) -> Void) {
		getCharts(id: id, currency: "usd", days: "100", isDaily: true, completion: completion)
	}
}
