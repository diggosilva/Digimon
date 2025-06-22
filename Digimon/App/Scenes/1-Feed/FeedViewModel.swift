//
//  FeedViewModel.swift
//  Digimon
//
//  Created by Diggo Silva on 23/04/25.
//

import Foundation
import Combine

enum FeedViewControllerStates: Equatable {
    case loading
    case loaded
    case error
    case filteredDigimons([Digimon])
}

protocol FeedViewModelProtocol: StatefulViewModel where State == FeedViewControllerStates {
    func numberOfItemsInSection() -> Int
    func cellForItem(at indexPath: IndexPath) -> Digimon
    func searchBar(textDidChange searchText: String)
    func fetchDigimons()
    func getDigimons() -> [Digimon]
}

class FeedViewModel: FeedViewModelProtocol {
    
    private var digimons: [Digimon] = []
    private var filteredDigimons: [Digimon] = []
    private var page = 0
    private var isLoading = false
    private var hasMorePage = true
    private var isSearching = false
    
    private let service: ServiceProtocol
    
    @Published private var state: FeedViewControllerStates = .loading
    
    var statePublisher: AnyPublisher<FeedViewControllerStates, Never> {
        $state.eraseToAnyPublisher()
    }
    
    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    func numberOfItemsInSection() -> Int {
        return filteredDigimons.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> Digimon {
        return filteredDigimons[indexPath.item]
    }
    
    func searchBar(textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredDigimons = digimons
        } else {
            isSearching = true
            filteredDigimons = digimons.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        updateState(.filteredDigimons(filteredDigimons))
    }
    
    func fetchDigimons() {
        guard !isLoading, hasMorePage else { return }
        
        isLoading = true
        state = .loading
        
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let newDigimons = try await service.getDigimons(page: page)
                
                if newDigimons.isEmpty {
                    self.hasMorePage = false
                    self.isLoading = false
                    return
                }
                
                self.page += 1
                self.digimons = newDigimons + self.digimons
                self.filteredDigimons = self.isSearching ? self.filteredDigimons : self.digimons
                self.state = .loaded
                
            } catch {
                self.state = .error
            }
            self.isLoading = false
        }
    }
    
    func getDigimons() -> [Digimon] {
        return digimons
    }
    
    private func updateState(_ newState: FeedViewControllerStates) {
        state = newState
    }
}
