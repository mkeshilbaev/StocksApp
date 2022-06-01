//
//  StockDetailModel.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 30.05.2022.
//

import Foundation

protocol StockDetailModelProtocol {
	var prices: [String] { get }
}

final class StockDetailModel: StockDetailModelProtocol {
	var stockDetail: StocksDetail

	init(stockDetail: StocksDetail) {
		self.stockDetail = stockDetail
	}

	var prices: [String] {
		["\(stockDetail.prices)"]
	}
}


