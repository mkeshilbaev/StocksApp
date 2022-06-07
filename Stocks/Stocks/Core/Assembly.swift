//
//  ModuleBuilder.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 29.05.2022.
//

import Foundation
import UIKit

final class Assembly {
	static let assembler: Assembly = .init()

	let favouritesService: FavouritesServiceProtocol = FavouritesLocalService()

	private init() {}

	private lazy var network: NetworkService = Network()
	private lazy var stocksService: StocksServiceProtocol = StocksService(network: network)
	private lazy var chartsService: ChartsServiceProtocol = ChartsService(network: network)

	func stocksModule() -> UIViewController {
		let presenter = StocksPresenter(service: stocksService)
		let view = StocksViewController(presenter: presenter)
		presenter.view = view
		return view
	}

	func favouritesModule() -> UIViewController {
		let presenter = FavouriteStocksPresenter(service: stocksService)
		let view = FavouritesViewController(presenter: presenter)
		presenter.view = view
		return view
	}

	func searchVC() -> UIViewController {
		UIViewController()
	}

	func tabBarController() -> UIViewController {
		let tabBar = UITabBarController()

		let stocksVC = stocksModule()
		stocksVC.tabBarItem = UITabBarItem(title: "Stocks", image: UIImage(named: "diagram.active"), tag: 0)

		let favouritesVC = favouritesModule()
		favouritesVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(named: "star.inactive"), tag: 1)
		
		let searchVC = searchVC()
		searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "loop.inactive"), tag: 2)

		tabBar.viewControllers = [stocksVC, favouritesVC, searchVC]
			.map { UINavigationController(rootViewController: $0)}

		return tabBar
	}

	func detailVC(model: StockModelProtocol) -> UIViewController {
		let presenter = StocksDetailPresenter(model: model, service: chartsService)
		let view = DetailsViewController(presenter: presenter)
		presenter.view = view as? StocksDetailViewProtocol
		return view
	}
}



