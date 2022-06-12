//
//  DetailTitleView.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 02.06.2022.
//

import UIKit

final class DetailTitleView: UIView {
	struct TitleModel {
		let symbol: String
		let name: String
		
		static func from(stockModel model: StockModelProtocol) -> TitleModel {
			TitleModel(symbol: model.symbol, name: model.name)
		}
	}
	
	private lazy var symbolLabel: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 18)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupSubviews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with model: TitleModel) {
		symbolLabel.text = model.symbol
		nameLabel.text = model.name
	}
	
	private func setupSubviews() {
		addSubview(symbolLabel)
		addSubview(nameLabel)
		
		NSLayoutConstraint.activate([
			symbolLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
			symbolLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
			symbolLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			symbolLabel.topAnchor.constraint(equalTo: topAnchor),
			
			nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
			nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
			nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			nameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor),
			nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

