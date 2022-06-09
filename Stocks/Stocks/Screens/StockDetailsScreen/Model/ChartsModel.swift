//
//  ChartsModel.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 07.06.2022.
//

import Foundation

struct ChartsModel {
	struct Period {
		let name: String
		let prices: [Double]
	}

	let periods: [Period]

	static func build(from response: Charts) -> ChartsModel {
		return ChartsModel(periods: [])
	}
}
