//
//  StockResponse.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 29.05.2022.
//

import Foundation

struct Stock: Decodable {
	let id, symbol, name: String
	let image: String
	let currentPrice: Double
	let priceChange24H, priceChangePercentage24H: Double

	enum CodingKeys: String, CodingKey {
		case id, symbol, name, image
		case currentPrice = "current_price"
		case priceChange24H = "price_change_24h"
		case priceChangePercentage24H = "price_change_percentage_24h"
	}
}
