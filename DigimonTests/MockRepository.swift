//
//  MockRepository.swift
//  Digimon
//
//  Created by Diggo Silva on 06/10/25.
//

import XCTest
@testable import Digimon

class MockRepository: RepositoryProtocol {
    var shouldSucceed: Bool = true
    var savedDigimon: Digimon?
    var digimonsToReturn: [Digimon] = []
    var savedDigimons: [Digimon]?
    var savedDigimonsCalled = false
    
    func getDigimons() -> [Digimon] {
        return digimonsToReturn
    }
    
    func saveDigimon(_ digimon: Digimon, completion: @escaping (Result<String, DSError>) -> Void) {
        if shouldSucceed {
            savedDigimon = digimon
            completion(.success("Digimon adicionado com sucesso!"))
        } else {
            completion(.failure(.digimonsFailed))
        }
    }
    
    func saveDigimons(_ digimons: [Digimon]) {
        savedDigimonsCalled = true
        savedDigimons = digimons
    }
}
