//
//  UIKit+Extension.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 27.05.2022.
//

import Foundation
import UIKit

extension UIColor {
	static let stockPriceUp: UIColor = {
		UIColor(red: 53/255, green: 199/255, blue: 89/255, alpha: 1.0)
	}()
	static let stockPriceDown: UIColor = {
		UIColor(red: 254/255, green: 61/255, blue: 48/255, alpha: 1.0)
	}()
}

extension UIColor {
	enum StockCell {
		static var grayCellBackground: UIColor  {
			return UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
		}
		static var whiteCellBackground: UIColor {
			return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
		}
		static var greenDayDeltaLabelBackground: UIColor {
			return UIColor(red: 36/255, green: 178/255, blue: 93/255, alpha: 1)
		}
	}
}

extension UIImageView {
	func load(urlString: String){
		guard let url = URL(string: urlString) else{ return }

		DispatchQueue.global().async { [weak self] in
			if let data = try? Data(contentsOf: url) {
				if let image = UIImage(data: data){
					DispatchQueue.main.async {
						self?.image = image
					}
				}
			}
		}
	}
}

