//
//  TabBarViewController.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 26.05.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

		let stocksVC = StocksViewController()
		let favouritesVC = FavouritesVC()
		let searchVC = SearchVC()

		self.setViewControllers([stocksVC, favouritesVC, searchVC], animated: true)

		guard let items = self.tabBar.items else { return }

		let images = ["diagram.active", "star.inactive", "loop.inactive"]

		for i in 0...2 {
			items[i].image = UIImage(named: images[i])
		}

		self.tabBar.tintColor = .systemBlue
    }

	class FavouritesVC: UIViewController {
		override func viewDidLoad() {
			super.viewDidLoad()
			view.backgroundColor = .white
		}
	}

	class SearchVC: UIViewController {
		override func viewDidLoad() {
			super.viewDidLoad()
			view.backgroundColor = .white
		}
	}


}
