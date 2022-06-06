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
		fatalError("init(coder:) has not been implemented")
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
	}

	private func setupNavigationBar() {
		navigationItem.titleView = titleView
		let backButton =  UIBarButtonItem(image: UIImage(named: "back"),
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
