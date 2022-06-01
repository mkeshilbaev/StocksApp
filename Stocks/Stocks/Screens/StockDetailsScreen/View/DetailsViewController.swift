//
//  DetailsViewController.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 26.05.2022.
//

import UIKit

class DetailsViewController: UIViewController {
	private let model: StockModelProtocol

	internal init(model: StockModelProtocol) {
		self.model = model
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private lazy var currentPriceLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 28)
		label.text = model.price
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var dayDeltaLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12)
		label.text = model.change
		label.textColor = model.changeColor
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		setupNavigationBarItems()
		setupViews()
		setupContraints()
    }

	 func setupNavigationBarItems(){
		let favouriteButton = createCustomButton(imageName: "favourite",
												 selector: #selector(addToFavouriteButtonTapped))
		let goBackButton = createCustomButton(imageName: "back",
											  selector: #selector(goBackButtonTapped))
		let customTitleView = createCustomTitleView(symbol: model.symbol,
													 companyName: model.name)

		 navigationItem.titleView = customTitleView
		 navigationItem.rightBarButtonItem = favouriteButton
		 navigationItem.leftBarButtonItem = goBackButton
	}

	private func setupViews(){
		view.backgroundColor = .white
		view.addSubview(currentPriceLabel)
		view.addSubview(dayDeltaLabel)
	}

	@objc
	private func addToFavouriteButtonTapped(){
		print("Favourite button tapped...")
	}

	@objc
	private func goBackButtonTapped(){
		dismiss(animated: true, completion: nil)
	}

	private func setupContraints(){
		NSLayoutConstraint.activate([
			currentPriceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			currentPriceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 162),

			dayDeltaLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			dayDeltaLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 8),
		])
	}

}

extension UIViewController {
	func createCustomTitleView(symbol: String, companyName: String) -> UIView {
		let symbolLabel = UILabel()
		symbolLabel.text = symbol
		symbolLabel.font = UIFont.boldSystemFont(ofSize: 18)
		symbolLabel.frame = CGRect(x: 0, y: 42, width: 0, height: 0)
		symbolLabel.sizeToFit()

		let companyNameLabel = UILabel()
		companyNameLabel.text = companyName
		companyNameLabel.font = UIFont.systemFont(ofSize: 12)
		companyNameLabel.frame = CGRect(x: 0, y: 70, width: 0, height: 0)
		companyNameLabel.sizeToFit()

		let view = UIView()
		view.frame = CGRect(x: 0, y: 70, width: max(symbolLabel.frame.size.width, companyNameLabel.frame.size.width), height: 44)
		view.addSubview(symbolLabel)
		view.addSubview(companyNameLabel)

		let widthDiff = companyNameLabel.frame.size.width - symbolLabel.frame.size.width

		if widthDiff < 0 {
			let newX = widthDiff / 2
			companyNameLabel.frame.origin.x = abs(newX)
		} else {
			let newX = widthDiff / 2
			symbolLabel.frame.origin.x = newX
		}

		return view
	}

	func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {
		let button = UIButton(type: .custom)
		button.setImage(UIImage(named: imageName), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.addTarget(self, action: selector, for: .touchUpInside)

		let barButtonItem = UIBarButtonItem(customView: button)
		return barButtonItem
	}
}
