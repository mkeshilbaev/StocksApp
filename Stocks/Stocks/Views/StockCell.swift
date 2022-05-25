//
//  StockCell.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 24.05.2022.
//

import UIKit

final class StockCell: UITableViewCell {

	private let containerView = UIView()

	private lazy var iconImageView: UIImageView = {
		let image = UIImageView(image: UIImage(named: "YNDX"))
		image.layer.cornerRadius = 12
		image.clipsToBounds = true
		return image
	}()

	private lazy var symbolNameLabel: UILabel = {
		let label = UILabel()
		label.text = "YNDX"
		label.font = UIFont.boldSystemFont(ofSize: 18)
		return label
	}()

	private lazy var companyNameLabel: UILabel = {
		let label = UILabel()
		label.text = "Yandex, LLC"
		label.font = .systemFont(ofSize: 12)
		return label
	}()

	private lazy var currentPriceLabel: UILabel = {
		let label = UILabel()
		label.text = "4 764,6 ₽"
		label.font = UIFont.boldSystemFont(ofSize: 18)
		return label
	}()

	private lazy var dayDeltaLabel: UILabel = {
		let label = UILabel()
		label.text = "+55 ₽ (1,15%)"
		label.font = .systemFont(ofSize: 12)
		label.textColor = UIColor(red: 36/255, green: 178/255, blue: 93/255, alpha: 1)
		return label
	}()

	private lazy var addToFavouriteButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setTitle("Star", for: .normal)
		button.setImage(UIImage(named:"star"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		return button
	}()


	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupViews(){
		[iconImageView, symbolNameLabel, companyNameLabel, addToFavouriteButton, currentPriceLabel, dayDeltaLabel].forEach {
			containerView.addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}

		contentView.addSubview(containerView)
		containerView.translatesAutoresizingMaskIntoConstraints = false

		setupContraints()
	}

	private func setupContraints(){
		NSLayoutConstraint.activate([
			containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
			containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

			iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
			iconImageView.heightAnchor.constraint(equalToConstant: 52),
			iconImageView.widthAnchor.constraint(equalToConstant: 52),
			iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
			iconImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),

			symbolNameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
			symbolNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),

			companyNameLabel.leadingAnchor.constraint(equalTo: symbolNameLabel.leadingAnchor),
			companyNameLabel.topAnchor.constraint(equalTo: symbolNameLabel.bottomAnchor),

			addToFavouriteButton.leadingAnchor.constraint(equalTo: symbolNameLabel.trailingAnchor, constant: 6),
			addToFavouriteButton.heightAnchor.constraint(equalToConstant: 16),
			addToFavouriteButton.widthAnchor.constraint(equalToConstant: 16),
			addToFavouriteButton.centerYAnchor.constraint(equalTo: symbolNameLabel.centerYAnchor),

			currentPriceLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),
			currentPriceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -17),

			dayDeltaLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
			dayDeltaLabel.centerYAnchor.constraint(equalTo: companyNameLabel.centerYAnchor)
		])
	}

	func configure(for indexPath: IndexPath) {
		if indexPath.row % 2 == 0 {
			containerView.backgroundColor = UIColor.StockCell.grayCellBackground
		}
		else {
			containerView.backgroundColor = UIColor.StockCell.whiteCellBackground
		}
		containerView.layer.cornerRadius = 16
		selectionStyle = .none
	}
}


extension UIColor {
	fileprivate enum StockCell {
		static var grayCellBackground: UIColor  {
			return UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
		}
		static var whiteCellBackground: UIColor {
			return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
		}
	}
}
