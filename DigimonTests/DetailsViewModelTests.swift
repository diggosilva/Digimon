//
//  DetailsViewModelTests.swift
//  DigimonTests
//
//  Created by Diggo Silva on 13/05/25.
//

import XCTest
@testable import Digimon

class MockDetails: ServiceProtocol {
    
    var isSuccess: Bool = true
    
    func getDigimons(page: Int, completion: @escaping (Result<[Digimon], DSError>) -> Void) {}
    
    func getDetails(of digimon: Digimon, completion: @escaping (Result<Details, DSError>) -> Void) {
        if isSuccess {
            completion(.success(Details(id: 1, name: "Alfamon", digiDescriptions: "")))
        } else {
            completion(.failure(.digimonsFailed))
        }
    }
}

class MockDetailsRepository: RepositoryProtocol {
    
    var shouldSucceed: Bool = true
    
    func getDigimons() -> [Digimon] {
        return []
    }
    
    func saveDigimon(_ digimon: Digimon, completion: @escaping (Result<String, DSError>) -> Void) {
        if shouldSucceed {
            completion(.success("Digimon adicionado com sucesso!"))
        } else {
            completion(.failure(.digimonsFailed))
        }
    }
    
    func saveDigimons(_ digimons: [Digimon]) {}
}

final class DetailsViewModelTests: XCTestCase {
    
    func testWhenSuccess() {
        let digimon = Digimon(id: 1, name: "Alfamon", href: "", image: "")
        let mockService = MockDetails()
        let sut = DetailsViewModel(digimon: digimon, service: mockService)
        
        sut.fetchDetails()
        
        let name = sut.getDigimon().name
        XCTAssertEqual(name, "Alfamon")
        XCTAssertTrue(sut.getDigimon().id == 1)
    }
    
    func testWhenFailure() {
        let digimon = Digimon(id: 1, name: "Alfamon", href: "", image: "")
        let mockService = MockDetails()
        mockService.isSuccess = false

        let sut = DetailsViewModel(digimon: digimon, service: mockService)
        
        var capturedState: DetailsViewControllerStates?
        sut.observeState { state in
            capturedState = state
        }
        
        sut.fetchDetails()
        
        if case .error = capturedState {
            print("DEBUG: TUDO CERTO POR AQUI")
        } else {
            XCTFail("Esperado o estado .error, mas recebeu .success")
        }
    }
    
    func testAddToFavoritesSuccess() {
        let digimon = Digimon(id: 1, name: "Alfamon", href: "", image: "")
        let mockService = MockDetails()
        let mockRepository = MockDetailsRepository()
        mockRepository.shouldSucceed = true

        let sut = DetailsViewModel(digimon: digimon, service: mockService, repository: mockRepository)

        var capturedState: DetailsViewControllerStates?
        sut.observeState { state in
            capturedState = state
        }

        sut.addToFavorites(digimon) { _ in }

        // Permite que o DispatchQueue.main.async seja processado
        waitForMainQueueExecution()

        if case let .showAlert(title, message) = capturedState {
            XCTAssertEqual(title, "Sucesso! ✅")
            XCTAssertEqual(message, "Digimon adicionado aos favoritos!")
        } else {
            XCTFail("Esperado estado .showAlert, mas recebeu \(String(describing: capturedState))")
        }
    }
    
    func testAddToFavoritesFailure() {
        let digimon = Digimon(id: 2, name: "Betamon", href: "", image: "")
        let mockService = MockDetails()
        
        let mockRepository = MockDetailsRepository()
        mockRepository.shouldSucceed = false
        
        let sut = DetailsViewModel(digimon: digimon, service: mockService, repository: mockRepository)
        
        var capturedState: DetailsViewControllerStates?
        sut.observeState { state in
            capturedState = state
        }
        
        sut.addToFavorites(digimon) { _ in }
        
        waitForMainQueueExecution()
        
        if case let .showAlert(title, message) = capturedState {
            XCTAssertEqual(title, "Ops... algo deu errado ⛔️")
            XCTAssertEqual(message, "Não foi possível carregar os digimons.")
        }
    }
    
    func waitForMainQueueExecution(timeout: TimeInterval = 0.01) {
        RunLoop.current.run(until: Date().addingTimeInterval(timeout))
    }
}
