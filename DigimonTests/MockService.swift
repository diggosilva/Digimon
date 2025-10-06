//
//  MockService.swift
//  DigimonTests
//
//  Created by Diggo Silva on 05/10/25.
//

import XCTest
import Combine
@testable import Digimon

class MockService: ServiceProtocol {
    
    var isSuccess: Bool = true
    var shouldReturnEmpty: Bool = false
    
    func getDigimons(page: Int) async throws -> [Digimon] {
        if isSuccess {
            if shouldReturnEmpty {
                return []
            }
            return [
                Digimon(id: 1, name: "Alfamon", href: "", image: ""),
                Digimon(id: 2, name: "Betamon", href: "", image: ""),
            ]
        } else {
            throw DSError.digimonsFailed
        }
    }
    
    func getDetails(of digimon: Digimon) async throws -> Details {
        if isSuccess {
            return Details(id: 1, name: "Alfamon", digiDescriptions: "Um digimon poderoso e misterioso.")
        } else {
            throw DSError.digimonsFailed
        }
    }
}
