//
//  StockModel.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 29.05.2022.
//

import Foundation
import UIKit

protocol StockModelProtocol {
	var id: String { get }
	var name: String { get }
	var iconUrl: String { get }
	var symbol: String {get }
	var price: String { get }
	var change: String { get }
	var changeColor: UIColor { get }
	var isFavourite: Bool { get set }
}

final class StockModel: StockModelProtocol {
	private let stock: Stock

	init(stock: Stock) {
		self.stock = stock
	}

	var id: String {
		stock.id
	}

	var name: String {
		stock.name
	}

	var iconUrl: String {
		stock.image
	}

	var symbol: String {
		stock.symbol.uppercased()
	}

	var price: String {
		"$\(stock.currentPrice.stringFormatted(by: .decimalFormatter))"
	}

	var change: String {
		"$\(stock.priceChange24H.stringFormatted(by: .decimalFormatter)) (\(stock.priceChangePercentage24H.stringFormatted(by: .decimalFormatter))%)"
	}

	var changeColor: UIColor {
		stock.priceChange24H >= 0 ? .stockPriceUp : .stockPriceDown
	}

	var isFavourite: Bool = false
}
