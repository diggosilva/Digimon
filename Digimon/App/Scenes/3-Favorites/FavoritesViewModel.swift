//
//  FavoritesViewModel.swift
//  Digimon
//
//  Created by Diggo Silva on 07/05/25.
//

import Foundation

protocol FavoritesViewModelProtocol {
    func getDigimons() -> [Digimon]
    func numberOfRowsInSection() -> Int
    func cellForRow(at indexPath: IndexPath) -> Digimon
    func loadDigimons()
    func saveDigimons()
    func removeDigimon(at index: Int)
    func setDelegate(_ delegate: FavoritesViewModelDelegate)
}

protocol FavoritesViewModelDelegate: AnyObject {
    func reloadTable()
}

class FavoritesViewModel: FavoritesViewModelProtocol {
    
    private var digimons: [Digimon] = []
    private let repository: RepositoryProtocol
    
    weak var delegate: FavoritesViewModelDelegate?
    
    init(repository: RepositoryProtocol = Repository()) {
        self.repository = repository
        loadDigimons()
    }
    
    func getDigimons() -> [Digimon] {
        return digimons
    }
    
    func numberOfRowsInSection() -> Int {
        return digimons.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> Digimon {
        return digimons[indexPath.row]
    }
    
    func loadDigimons() {
        digimons = repository.getDigimons()
        delegate?.reloadTable()
    }
    
    func saveDigimons() {
        repository.saveDigimons(digimons)
    }
    
    func removeDigimon(at index: Int) {
        digimons.remove(at: index)
    }
    
    func setDelegate(_ delegate: FavoritesViewModelDelegate) {
        self.delegate = delegate
    }
}
