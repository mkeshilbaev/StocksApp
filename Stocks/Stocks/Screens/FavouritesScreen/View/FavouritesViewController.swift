//
//  FavouritesViewController.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 01.06.2022.
//

import UIKit

class FavouritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()
    }

	private func setupViews(){
		view.backgroundColor = .white
		title = "Favourites"
		navigationItem.largeTitleDisplayMode = .always
		navigationController?.navigationBar.prefersLargeTitles = true
	}
}


