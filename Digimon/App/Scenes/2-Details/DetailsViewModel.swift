//
//  DetailsViewModel.swift
//  Digimon
//
//  Created by Diggo Silva on 27/04/25.
//

import Foundation
import Combine

enum DetailsViewControllerStates {
    case loading
    case loaded(Details)
    case error
    case showAlert(title: String, message: String)
}

protocol DetailsViewModelProtocol: StatefulViewModel where State == DetailsViewControllerStates {
    func getDigimon() -> Digimon
    func fetchDetails()
    func addToFavorites(_ digimon: Digimon, completion: @escaping(Result<String, DSError>) -> Void)
}

class DetailsViewModel: DetailsViewModelProtocol {
    
    private let digimon: Digimon
    private var details: Details?
    
    private let service: ServiceProtocol
    private let repository: RepositoryProtocol
    
    @Published private var state: DetailsViewControllerStates = .loading
    
    var statePublisher: AnyPublisher<DetailsViewControllerStates, Never> {
        $state.eraseToAnyPublisher()
    }
    
    init(digimon: Digimon, service: ServiceProtocol = Service(), repository: RepositoryProtocol = Repository()) {
        self.digimon = digimon
        self.service = service
        self.repository = repository
    }
    
    func getDigimon() -> Digimon {
        return digimon
    }
    
    func fetchDetails() {
        state = .loading
        
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let details = try await service.getDetails(of: digimon)
                self.details = details
                self.state = .loaded(details)
            } catch {
                self.state = .error
                print("DEBUG: Failed to fetch details: \(error.localizedDescription)")
            }
        }
    }
    
    func addToFavorites(_ digimon: Digimon, completion: @escaping(Result<String, DSError>) -> Void) {
        repository.saveDigimon(digimon) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.state = .showAlert(title: "Sucesso! ✅", message: "Digimon adicionado aos favoritos!")
                case .failure(let error):
                    self.state = .showAlert(title: "Ops... algo deu errado ⛔️", message: error.rawValue)
                }
            }
        }
    }
}
