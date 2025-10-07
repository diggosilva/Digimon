//
//  DetailsViewModelTests.swift
//  DigimonTests
//
//  Created by Diggo Silva on 13/05/25.
//

import XCTest
import Combine
@testable import Digimon

final class DetailsViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    var digimon: Digimon!
    var mockService: MockService!
    var mockRepository: MockRepository!
    var sut: DetailsViewModel!

    override func setUp() {
        super.setUp()
        // Configuração comum para todos os testes
        digimon = Digimon(id: 1, name: "Alfamon", href: "http://example.com/alfamon", image: "http://example.com/alfamon.png")
        mockService = MockService()
        mockRepository = MockRepository()
        sut = DetailsViewModel(digimon: digimon, service: mockService, repository: mockRepository)
    }

    override func tearDown() {
        // Limpeza após cada teste
        cancellables.removeAll()
        digimon = nil
        mockService = nil
        mockRepository = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Testes do ViewModel

    func testWhenSuccess() async {
        let expectation = XCTestExpectation(description: "State deveria ser .loaded com os detalhes do digimon")

        sut.statePublisher
            .sink { state in
                if case .loaded(let details) = state {
                    XCTAssertEqual(details.name, "Alfamon")
                    XCTAssertEqual(details.id, 1)
                    expectation.fulfill()
                } else if case .loading = state {
                    // Ignora o estado inicial de carregamento
                } else {
                    XCTFail("Esperado estado .loaded, mas recebeu \(state)")
                }
            }
            .store(in: &cancellables)

        sut.fetchDetails()

        await fulfillment(of: [expectation], timeout: 2.0)

        // Assegura que o ViewModel ainda contém o digimon original e correto
        XCTAssertEqual(sut.getDigimon().name, "Alfamon")
        XCTAssertEqual(sut.getDigimon().id, 1)
    }

    func testWhenFailure() async {
        mockService.isSuccess = false // Configura o mock para simular uma falha
        let expectation = XCTestExpectation(description: "State deveria ser .error")

        sut.statePublisher
            .sink { state in
                if case .error = state {
                    expectation.fulfill()
                } else if case .loading = state {
                    // Ignora o estado inicial de carregamento
                } else {
                    XCTFail("Esperado estado .error, mas recebeu \(state)")
                }
            }
            .store(in: &cancellables)

        sut.fetchDetails()

        await fulfillment(of: [expectation], timeout: 2.0)
    }

    func testAddToFavoritesSuccess() async {
        mockRepository.shouldSucceed = true // Configura o mock para sucesso na persistência
        let expectation = XCTestExpectation(description: "State deveria ser .showAlert de sucesso")

        sut.statePublisher
            .sink { state in
                if case let .showAlert(title, message) = state {
                    XCTAssertEqual(title, "Sucesso! ✅")
                    XCTAssertEqual(message, "Digimon adicionado aos favoritos!")
                    expectation.fulfill()
                } else if case .loading = state {
                    // Ignora o estado inicial de carregamento
                } else {
                    XCTFail("Esperado estado .showAlert de sucesso, mas recebeu \(state)")
                }
            }
            .store(in: &cancellables)

        sut.addToFavorites(digimon) { _ in }

        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertEqual(mockRepository.savedDigimon?.name, "Alfamon", "O digimon correto deveria ter sido salvo no repositório.")
    }

    func testAddToFavoritesFailure() async {
        mockRepository.shouldSucceed = false // Configura o mock para falha na persistência
        let expectation = XCTestExpectation(description: "State deveria ser .showAlert de falha")

        sut.statePublisher
            .sink { state in
                if case let .showAlert(title, message) = state {
                    XCTAssertEqual(title, "Ops... algo deu errado ⛔️")
                    
                    // A mensagem de erro deve corresponder exatamente ao rawValue do DSError
                    XCTAssertEqual(message, DSError.digimonsFailed.rawValue)
                    expectation.fulfill()
                } else if case .loading = state {
                    
                    // Ignora o estado inicial de carregamento
                } else {
                    XCTFail("Esperado estado .showAlert de falha, mas recebeu \(state)")
                }
            }
            .store(in: &cancellables)

        sut.addToFavorites(digimon) { _ in }

        await fulfillment(of: [expectation], timeout: 1.0)
    }
}
