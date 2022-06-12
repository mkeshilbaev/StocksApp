//
//  ChartsModel.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 07.06.2022.
//

import Foundation

struct ChartsModel {
	let periods: [Period]

	struct Period {
		let name: String
		let prices: [Double]
	}

	static func build(from charts: Charts) -> ChartsModel {
		return ChartsModel(periods: [
			Period(name: "W", prices: charts.prices.suffix(7).map { $0.price }),
			Period(name: "M", prices: charts.prices.suffix(30).map { $0.price }),
			Period(name: "6M", prices: charts.prices.suffix(180).map { $0.price }),
			Period(name: "1Y", prices: charts.prices.suffix(365).map { $0.price })
		]
		)
	}
}
