//
//  FavouritesService.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 01.06.2022.
//

import Foundation

///Сервис для сохранения избранных.
protocol FavouritesServiceProtocol {
	func save(id: String)
	func remove(id: String)
	func isFavourite(for id: String) -> Bool
}


