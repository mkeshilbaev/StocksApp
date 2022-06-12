//
//  UserDefaultsFavouritesService.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 03.06.2022.
//

import Foundation

//Реализация сохранения избранных в UserDefaults
final class FavouritesService: FavouritesServiceProtocol {
	private let key = "favourite_key"
	private lazy var favouriteIds: [String] = {
		guard let data = UserDefaults.standard.object(forKey: key) as? Data,
			  let ids = try? JSONDecoder().decode([String].self, from: data) else {
			return []
		}
		
		return ids
	}()

	func save(id: String) {
		favouriteIds.append(id)
		updateRepo()
	}

	func remove(id: String) {
		if let index = favouriteIds.firstIndex(where: { $0 == id }) {
			favouriteIds.remove(at: index)
			updateRepo()
		}
	}

	func isFavourite(for id: String) -> Bool {
		favouriteIds.contains(id)
	}

	private func updateRepo() {
		guard let data = try? JSONEncoder().encode(favouriteIds) else {
			return
		}

		UserDefaults.standard.set(data, forKey: key)
	}
}

