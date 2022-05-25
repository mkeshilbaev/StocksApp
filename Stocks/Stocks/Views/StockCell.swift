//
//  StockCell.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 24.05.2022.
//

import UIKit

class StockCell: UITableViewCell {

	private lazy var iconView: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		image.translatesAutoresizingMaskIntoConstraints = false
		image.layer.cornerRadius = 12
		image.clipsToBounds = true
		image.image = UIImage(named: "YNDX")
		return image
	}()

	private lazy var symbolName: UILabel = {
		let label = UILabel()
		label.text = "YNDX"
		label.font = UIFont.boldSystemFont(ofSize: 18)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var companyName: UILabel = {
		let label = UILabel()
		label.text = "Yandex, LLC"
		label.font = .systemFont(ofSize: 12)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var currentPrice: UILabel = {
		let label = UILabel()
		label.text = "4 764,6 ₽"
		label.font = UIFont.boldSystemFont(ofSize: 24)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var dayDelta: UILabel = {
		let label = UILabel()
		label.text = "+55 ₽ (1,15%)"
		label.font = .systemFont(ofSize: 12)
		label.textColor = UIColor(red: 36/255, green: 178/255, blue: 93/255, alpha: 1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var favoutriteButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setTitle("Star", for: .normal)
		button.setImage(UIImage(named:"star"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()


	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
	}

	private func setupViews(){
		contentView.addSubview(iconView)
		contentView.addSubview(symbolName)
		contentView.addSubview(companyName)
		contentView.addSubview(favoutriteButton)
		contentView.addSubview(currentPrice)
		contentView.addSubview(dayDelta)



		setupContraints()
	}

	private func setupContraints(){
		iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
		iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
		iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		iconView.heightAnchor.constraint(equalToConstant: 52).isActive = true
		iconView.widthAnchor.constraint(equalToConstant: 52).isActive = true

		symbolName.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12).isActive = true
		symbolName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14).isActive = true

		companyName.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12).isActive = true
		companyName.topAnchor.constraint(equalTo: symbolName.bottomAnchor).isActive = true

		favoutriteButton.leadingAnchor.constraint(equalTo: symbolName.trailingAnchor, constant: 6).isActive = true
		favoutriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17).isActive = true
		favoutriteButton.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 35).isActive = true
		favoutriteButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
		favoutriteButton.widthAnchor.constraint(equalToConstant: 16).isActive = true

		currentPrice.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14).isActive = true
		currentPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17).isActive = true

		dayDelta.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
		dayDelta.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		dayDelta.topAnchor.constraint(equalTo: currentPrice.bottomAnchor).isActive = true

	}


}
