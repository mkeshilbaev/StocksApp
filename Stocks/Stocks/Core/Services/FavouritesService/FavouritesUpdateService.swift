//
//  FavouritesUpdateService.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 03.06.2022.
//

import Foundation

@objc protocol FavouritesUpdateServiceProtocol {
	func setFavourite(notification: Notification)
}

extension FavouritesUpdateServiceProtocol {
	func startFavoritesNotificationObserving(){
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(setFavourite),
			name: NSNotification.Name.favourites,
			object: nil)
	}
}

extension NSNotification.Name {
	static let favourites = NSNotification.Name("Update.Favorite.Stocks")
}

extension Notification {
	var stockID: String? {
		guard let userInfo = userInfo,
			  let id = userInfo["id"] as? String else { return nil }
		return id
	}
}
