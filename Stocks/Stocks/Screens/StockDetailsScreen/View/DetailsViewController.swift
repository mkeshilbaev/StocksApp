//
//  DetailsViewController.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 26.05.2022.
//

import UIKit

final class DetailsViewController: UIViewController {
	private lazy var titleView: UIView = {
		let view = DetailTitleView()
		view.configure(with: presenter.titleModel)
		return view
	}()

	private lazy var chartsContainerView: ChartsContainerView = {
		let view = ChartsContainerView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	private lazy var priceLabelStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.distribution = .fillEqually
		stackView.spacing = 8
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

	private lazy var currentPriceLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 28)
		label.text = presenter.price
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var dayDeltaLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12)
		label.textColor = UIColor(red: 36/255, green: 178/255, blue: 93/255, alpha: 1)
		label.text = presenter.dayDelta
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var buyButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Buy for \(currentPriceLabel.text!)", for: .normal)
		button.backgroundColor = .black
		button.titleLabel?.font = .boldSystemFont(ofSize: 16)
		button.layer.cornerRadius = 16
		button.setTitleColor(.white, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	private let presenter: StocksDetailPresenterProtocol

	override var hidesBottomBarWhenPushed: Bool {
		get { true }
		set { super.hidesBottomBarWhenPushed = newValue }
	}

	init(presenter: StocksDetailPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented!")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupView()
		setupNavigationBar()
		setupFavouriteButton()

		presenter.loadView()
	}

	private func setupView() {
		view.backgroundColor = .white

		priceLabelStackView.addArrangedSubview(currentPriceLabel)
		priceLabelStackView.addArrangedSubview(dayDeltaLabel)

		view.addSubview(chartsContainerView)
		view.addSubview(priceLabelStackView)
		view.addSubview(buyButton)

		NSLayoutConstraint.activate([
			priceLabelStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 63),
			priceLabelStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

			chartsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			chartsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			chartsContainerView.topAnchor.constraint(equalTo: priceLabelStackView.bottomAnchor, constant: 30),

			buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
			buyButton.heightAnchor.constraint(equalToConstant: 56)
		])
	}

	private func setupNavigationBar() {
		navigationItem.titleView = titleView
		let backButton =  UIBarButtonItem(
			image: UIImage(named: "back"),
			style: .plain,
			target: self,
			action: #selector(backBattonTapped))
		backButton.tintColor = .black
		navigationItem.leftBarButtonItem = backButton
	}

	private func setupFavouriteButton() {
		let button = UIButton(type: .custom)
		button.setImage(UIImage(named: "favourite"), for: .normal)
		button.setImage(UIImage(named: "star.filled"), for: .selected)
		button.isSelected = presenter.favouriteButtonIsSelected
		button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
		button.addTarget(self, action: #selector(favouriteTapped(_:)), for: .touchUpInside)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
	}

	@objc
	private func favouriteTapped(_ sender: UIButton) {
		sender.isSelected.toggle()
		presenter.favouriteButtonTapped()
	}

	@objc
	private func backBattonTapped() {
		navigationController?.popViewController(animated: true)
	}
}

extension DetailsViewController: StocksDetailViewProtocol {
	func updateView(withLoader isLoading: Bool) {
		chartsContainerView.configure(with: isLoading)
	}
	func updateView(withError message: String) {
		let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
	func updateView(withModel model: ChartsModel) {
		chartsContainerView.configure(with: model)
	}
}
