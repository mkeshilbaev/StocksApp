//
//  NSObject+Extension.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 29.05.2022.
//

import Foundation

extension NSObject{
	static var typeName: String{
		String(describing: self)
	}
}
