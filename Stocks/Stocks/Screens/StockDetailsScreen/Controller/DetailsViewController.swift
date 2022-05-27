//
//  DetailsViewController.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 26.05.2022.
//

import UIKit

class DetailsViewController: UIViewController {

	private lazy var currentPriceLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 28)
		label.text = "$131.93"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var dayDeltaLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12)
		label.textColor = UIColor(red: 36/255, green: 178/255, blue: 93/255, alpha: 1)
		label.text = "+$0.12 (1,15%)"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
		setupNavigationBarItems()
		setupViews()
		setupContraints()
    }

	 func setupNavigationBarItems(){
		createCustomNavigationBar()

		let favouriteButton = createCustomButton(imageName: "favourite",
												 selector: #selector(addToFavouriteButtonTapped))
		let goBackButton = createCustomButton(imageName: "back",
											  selector: #selector(goBackButtonTapped))
		let customTitleView = createCustomTitleView(symbol: "BTC",
													companyName: "Bitcoin")

		navigationItem.titleView = customTitleView
		navigationItem.rightBarButtonItem = favouriteButton
		navigationItem.leftBarButtonItem = goBackButton
	}

	func configureData(){

	}

	private func setupViews(){
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

	func createCustomNavigationBar(){
		navigationController?.navigationBar.barTintColor = UIColor.lightGray
	}

	func createCustomTitleView(symbol: String, companyName: String) -> UIView {
		let view = UIView()
		view.frame = CGRect(x: 0, y: 0, width: 40, height: 44)

		let symbolLabel = UILabel()
		symbolLabel.text = symbol
		symbolLabel.font = UIFont.systemFont(ofSize: 18)
		symbolLabel.frame = CGRect(x: 0, y: 42, width: symbolLabel.intrinsicContentSize.width, height: 24)
		view.addSubview(symbolLabel)

		let companyNameLabel = UILabel()
		companyNameLabel.text = companyName
		companyNameLabel.font = UIFont.systemFont(ofSize: 12)
		companyNameLabel.frame = CGRect(x: 0, y: 70, width: companyNameLabel.intrinsicContentSize.width, height: 16)
		view.addSubview(companyNameLabel)

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
