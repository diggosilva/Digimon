//
//  FeedViewModel.swift
//  Digimon
//
//  Created by Diggo Silva on 23/04/25.
//

import Foundation

enum FeedViewControllerStates {
    case loading
    case loaded
    case error
}

protocol FeedViewModelProtocol {
    var state: Bindable<FeedViewControllerStates> { get }
    func numberOfItemsInSection() -> Int
    func cellForItem(at indexPath: IndexPath) -> Digimon
    func fetchDigimons()
    func getDigimons() -> [Digimon]
}

class FeedViewModel: FeedViewModelProtocol {
    var state: Bindable<FeedViewControllerStates> = Bindable(value: .loading)
    
    private let service: ServiceProtocol
    var digimons: [Digimon] = []
    var page = 0
    
    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    func numberOfItemsInSection() -> Int {
        return digimons.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> Digimon {
        return digimons[indexPath.item]
    }
    
    func fetchDigimons() {
        state.value = .loading
        
        self.service.getDigimons(page: self.page) { result in
            switch result {
            case .success(let digimons):
                self.digimons = digimons
                print("DEBUG: Fetched \(digimons)")
                self.state.value = .loaded
                
            case .failure:
                print("DEBUG: Error fetching digimons")
                self.state.value = .error
            }
        }
    }
    
    func getDigimons() -> [Digimon] {
        return digimons
    }
}
