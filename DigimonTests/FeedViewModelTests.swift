//
//  FeedViewModelTests.swift
//  DigimonTests
//
//  Created by Diggo Silva on 12/05/25.
//

import XCTest
@testable import Digimon

class MockFeed: ServiceProtocol {
    
    var isSuccess: Bool = true
    
    func getDigimons(page: Int, completion: @escaping (Result<[Digimon], DSError>) -> Void) {
        if isSuccess {
            completion(.success([
                Digimon(id: 1, name: "Alfamon", href: "", image: ""),
                Digimon(id: 2, name: "Betamon", href: "", image: ""),
            ]))
        } else {
            completion(.failure(.digimonsFailed))
        }
    }
    
    func getDetails(of digimon: Digimon, completion: @escaping (Result<Details, DSError>) -> Void) {}
}

final class DigimonTests: XCTestCase {
    
    func testWhenSuccess() {
        let mockService = MockFeed()
        let sut = FeedViewModel(service: mockService)
        
        sut.fetchDigimons()
        XCTAssertEqual(sut.numberOfItemsInSection(), 2)
        
        let firstName = sut.cellForItem(at: IndexPath(item: 0, section: 0)).name
        let secondId = sut.cellForItem(at: IndexPath(item: 1, section: 0)).id
        XCTAssertEqual(firstName, "Alfamon")
        XCTAssertEqual(secondId, 2)
        
        sut.searchBar(textDidChange: "Bet")
        XCTAssertEqual(sut.numberOfItemsInSection(), 1)
        
        sut.searchBar(textDidChange: "")
        XCTAssertEqual(sut.getDigimons().count, 2)
    }
    
    func testWhenFailure() {
        let mockService = MockFeed()
        mockService.isSuccess = false
        let sut = FeedViewModel(service: mockService)
        
        sut.fetchDigimons()
        XCTAssertEqual(sut.numberOfItemsInSection(), 0)
    }
}
