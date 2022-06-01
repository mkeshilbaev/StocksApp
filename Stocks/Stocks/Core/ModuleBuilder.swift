//
//  ModuleBuilder.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 29.05.2022.
//

import Foundation
import UIKit

final class ModuleBuilder {
	private init() {}

	private lazy var network: NetworkService = {
		Network()
	}()

	lazy var favouritesService: FavouritesServiceProtocol = FavouritesLocalService()

	static let shared: ModuleBuilder = .init()

	func stockService() -> StocksServiceProtocol {
		StocksService(client: network)
	}
	
	func stockModule() -> UIViewController {
		let presenter = StocksPresenter(service: stockService())
		let view = StocksViewController(presenter: presenter)
		presenter.view = view

		return view
	}

	func favouritesModule() -> UIViewController {
		let view = FavouritesViewController()
		return view
	}

	func searchVC() -> UIViewController {
		UIViewController()
	}

	func tabBarController() -> UIViewController {
		let tabBar = UITabBarController()

		let stocksVC = stockModule()
		stocksVC.tabBarItem = UITabBarItem(title: "Stocks", image: UIImage(named: "diagram.active"), tag: 0)

		let favouritesVC = favouritesModule()
		favouritesVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(named: "star.inactive"), tag: 1)

		let searchVC = searchVC()
		searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "loop.inactive"), tag: 2)

		tabBar.viewControllers = [stocksVC, favouritesVC, searchVC]
			.map { UINavigationController(rootViewController: $0)}

		return tabBar
	}

}



