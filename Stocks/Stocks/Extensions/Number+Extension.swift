//
//  Number+Extension.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 27.05.2022.
//

import Foundation


extension NumberFormatter {
	static let percentageFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .percent
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = 2
		return formatter
	}()

	static let decimalFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.locale = .current
		formatter.numberStyle = .decimal
		formatter.maximumFractionDigits = 2
		formatter.minimumFractionDigits = 0
		return formatter
	}()
}


extension Double {
	func stringFormatted(by formatter: NumberFormatter) -> String {
		return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
	}
}
