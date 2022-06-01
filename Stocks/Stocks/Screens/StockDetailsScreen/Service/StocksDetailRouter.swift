//
//  StocksDetailRouter.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 30.05.2022.
//

import Foundation

enum StocksDetailRouter: Router {
	case stockDetails(coin: String, currency: String, days: String, interval: String)

	var baseUrl: String {
		"https://api.coingecko.com"
	}

	var path: String {
		switch self {
		case .stockDetails:
			return "/api/v3/coins/bitcoin/market_chart"
		}
	}

	var method: HTTPMethod {
		switch self {
		case .stockDetails:
			return .get
		}
	}

	var parameters: Parameters{
		switch self {
		case .stockDetails(let coin, let currency, let days, let interval):
			return ["": coin, "vs_currency": currency, "days": days, "interval": interval]
		}
	}
}
