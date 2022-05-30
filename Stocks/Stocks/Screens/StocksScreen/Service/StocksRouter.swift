//
//  StocksRouter.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 29.05.2022.
//

import Foundation

enum StockRouter: Router {
	case stocks(currency: String, count: String)

	var baseUrl: String {
		"https://api.coingecko.com"
	}

	var path: String {
		switch self {
		case .stocks:
			return "/api/v3/coins/markets"
		}
	}

	var method: HTTPMethod {
		switch self {
		case .stocks:
			return .get
		}
	}

	var parameters: Parameters{
		switch self {
		case .stocks(let currency, let count):
			return ["vs_currency": currency, "per_page": count]
		}
	}
}
