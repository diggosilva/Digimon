//
//  FavoritesViewModel.swift
//  Digimon
//
//  Created by Diggo Silva on 07/05/25.
//

import Foundation

protocol FavoritesViewModelProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRow(at indexPath: IndexPath) -> Digimon
}

class FavoritesViewModel: FavoritesViewModelProtocol {
    
    private var favorites: [Digimon] = []
    
    func numberOfRowsInSection() -> Int {
        return favorites.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> Digimon {
        return favorites[indexPath.row]
    }
}
