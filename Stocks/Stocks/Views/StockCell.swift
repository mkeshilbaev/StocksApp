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
		label.font = .systemFont(ofSize: 18)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()


	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupViews(){
		contentView.addSubview(iconView)
		contentView.addSubview(symbolName)

		setupContraints()
	}

	private func setupContraints(){
		iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
		iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
		iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
		iconView.heightAnchor.constraint(equalToConstant: 52).isActive = true
		iconView.widthAnchor.constraint(equalToConstant: 52).isActive = true

		symbolName.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12).isActive = true
		symbolName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14).isActive = true

	}


}
