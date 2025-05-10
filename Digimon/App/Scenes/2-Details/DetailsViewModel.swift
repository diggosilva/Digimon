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
    case showAlert(title: String, message: String)
}

protocol DetailsViewModelProtocol {
    func getDigimon() -> Digimon
    func fetchDetails()
    func addToFavorites(_ digimon: Digimon, completion: @escaping(Result<String, DSError>) -> Void)
    func observeState(_ observer: @escaping(DetailsViewControllerStates) -> Void)
}

class DetailsViewModel: DetailsViewModelProtocol {
    
    private var state: Bindable<DetailsViewControllerStates> = Bindable(value: .loading)
    private let digimon: Digimon
    private var details: Details?
    
    private let service: ServiceProtocol
    private let repository: RepositoryProtocol
    
    init(digimon: Digimon, service: ServiceProtocol = Service(), repository: RepositoryProtocol = Repository()) {
        self.digimon = digimon
        self.service = service
        self.repository = repository
    }
    
    func getDigimon() -> Digimon {
        return digimon
    }
    
    func fetchDetails() {
        state.value = .loading
        
        service.getDetails(of: digimon) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let details):
                self.state.value = .loaded(details)
                
            case .failure(let error):
                self.state.value = .error
                print("DEBUG: Failed to fetch details: \(error.localizedDescription)")
            }
        }
    }
    
    func addToFavorites(_ digimon: Digimon, completion: @escaping(Result<String, DSError>) -> Void) {
        repository.saveDigimon(digimon) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.state.value = .showAlert(title: "Sucesso! ✅", message: "Digimon adicionado aos favoritos!")
                case .failure(let error):
                    self.state.value = .showAlert(title: "Ops... algo deu errado ⛔️", message: error.rawValue)
                }
            }
        }
    }
    
    func observeState(_ observer: @escaping(DetailsViewControllerStates) -> Void) {
        state.bind(observer: observer)
    }
}
