//
//  FavouritesService.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 01.06.2022.
//

import Foundation

protocol FavouritesServiceProtocol{
	func save(id: String)
	func remove(id: String)
	func isFavourite(for id: String) -> Bool
}

final class FavouritesService: FavouritesServiceProtocol{
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

	private func updateRepo(){
		guard let data = try? JSONEncoder().encode(favouriteIds) else{
			return
		}
		UserDefaults.standard.set(data, forKey: key)
		print("UserDefaults update")
	}
}


final class FavouritesLocalService: FavouritesServiceProtocol {
	private lazy var path: URL = {
		FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("Favourites")
	}()

	private lazy var favouriteIds: [String] = {
		do {
			let data = try Data(contentsOf: path)
			return try JSONDecoder().decode([String].self, from: data)
		} catch {
			print("FileManager ReadError -", error.localizedDescription)
		}
		return []
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

	private func updateRepo(){
		do {
			let data = try JSONEncoder().encode(favouriteIds)
			try data.write(to: path)
		} catch {
			print("FileManager WriteError - ", error.localizedDescription)
		}
	}
}
