//
//  DetailsViewModel.swift
//  Digimon
//
//  Created by Diggo Silva on 27/04/25.
//

import Foundation

enum DetailsViewControllerStates {
    case loading
    case loaded(Details)
    case error
}

protocol DetailsViewModelProtocol {
    func getDetailsDigimon() -> Digimon
    func fetchDetails()
    func observeState(_ observer: @escaping(DetailsViewControllerStates) -> Void)
}

class DetailsViewModel: DetailsViewModelProtocol {
    private var state: Bindable<DetailsViewControllerStates> = Bindable(value: .loading)
    
    private let digimon: Digimon
    private let service: ServiceProtocol
    private var details: Details?
    
    init(digimon: Digimon, service: ServiceProtocol = Service()) {
        self.digimon = digimon
        self.service = service
    }
    
    func getDetailsDigimon() -> Digimon {
        return digimon
    }
    
    func fetchDetails() {
        state.value = .loading
        
        service.getDetails(of: digimon) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let details):
                self.state.value = .loaded(details)
                print("DEBUG: Successfully fetched!")
                
            case .failure(let error):
                self.state.value = .error
                print("DEBUG: Failed to fetch details: \(error.localizedDescription)")
            }
        }
    }
    
    func observeState(_ observer: @escaping(DetailsViewControllerStates) -> Void) {
        state.bind(observer: observer)
    }
}
