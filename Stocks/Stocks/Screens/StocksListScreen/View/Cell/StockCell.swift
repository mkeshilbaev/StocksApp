//
//  StockCell.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 24.05.2022.
//

import UIKit

final class StockCell: UITableViewCell {
	private var favouriteAction: (() -> Void)?
	private let containerView = UIView()

	private lazy var iconImageView: UIImageView = {
		let image = UIImageView()
		image.layer.cornerRadius = 12
		image.clipsToBounds = true
		return image
	}()

	private lazy var symbolNameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 18)
		return label
	}()

	private lazy var companyNameLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12)
		return label
	}()

	private lazy var currentPriceLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 18)
		return label
	}()

	private lazy var dayDeltaLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12)
		label.textColor = UIColor.StockCell.greenDayDeltaLabelBackground
		return label
	}()

	private lazy var addToFavouriteButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setTitle("Star", for: .normal)
		button.setImage(UIImage(named:"star"), for: .normal)
		button.setImage(UIImage(named:"star.filled"), for: .selected)
		button.imageView?.contentMode = .scaleAspectFit
		button.addTarget(self, action: #selector(favouriteButtonTap), for: .touchUpInside)
		return button
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		favouriteAction = nil
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented...")
	}

	@objc func favouriteButtonTap(){
		addToFavouriteButton.isSelected.toggle()
		favouriteAction?()
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

	func configure(with model: StockModelProtocol, for indexPath: IndexPath) {
		symbolNameLabel.text = model.symbol
		companyNameLabel.text = model.name
		currentPriceLabel.text = model.price
		dayDeltaLabel.text = model.change
		dayDeltaLabel.textColor = model.changeColor
		iconImageView.load(urlString: model.iconUrl)

		if indexPath.row.isMultiple(of: 2) {
			containerView.backgroundColor = UIColor.StockCell.grayCellBackground
		}
		else {
			containerView.backgroundColor = UIColor.StockCell.whiteCellBackground
		}
		containerView.layer.cornerRadius = 16
		selectionStyle = .none

		addToFavouriteButton.isSelected = model.isFavourite

		favouriteAction = {
			model.setFavourite()
		}
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
			iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

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
}



