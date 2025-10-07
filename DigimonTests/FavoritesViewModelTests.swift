//
//  FavoritesViewModelTests.swift
//  DigimonTests
//
//  Created by Diggo Silva on 14/05/25.
//

import XCTest
@testable import Digimon

class MockFavoritesDelegate: FavoritesViewModelDelegate {
    var reloadTableCalled = false
    
    func reloadTable() {
        reloadTableCalled = true
    }
}

final class FavoritesViewModelTests: XCTestCase {
    var backupDigimons: [Digimon] = [
        Digimon(id: 1, name: "Digimon 1", href: "", image: ""),
        Digimon(id: 2, name: "Digimon 2", href: "", image: ""),
    ]
    
    func testLoadDigimonsShouldLoadFromRepositoryAndNotifyDelegate() {
        let mockRepository = MockRepository()
        mockRepository.digimonsToReturn = backupDigimons
        
        let sut = FavoritesViewModel(repository: mockRepository)
        
        let delegate = MockFavoritesDelegate()
        sut.setDelegate(delegate)
        
        sut.loadDigimons()
        
        XCTAssertEqual(sut.getDigimons().count, 2)
        XCTAssertTrue(delegate.reloadTableCalled)
    }
    
    func testNumberOfRowShouldReturnCountOfDigimons() {
        let mockRepository = MockRepository()
        mockRepository.digimonsToReturn = backupDigimons
        
        let sut = FavoritesViewModel(repository: mockRepository)
        
        sut.loadDigimons()
        XCTAssertEqual(sut.numberOfRowsInSection(), 2)
    }
    
    func testCellForRowShouldReturnCellWithDigimonName() {
        let mockRepository = MockRepository()
        mockRepository.digimonsToReturn = backupDigimons
        
        let sut = FavoritesViewModel(repository: mockRepository)
        sut.loadDigimons()
        
        let firstName = sut.cellForRow(at: IndexPath(row: 0, section: 0)).name
        XCTAssertEqual(firstName, "Digimon 1")
    }
    
    func testRemoveDigimonShouldRemoveCorrectItem() {
        let mockRepository = MockRepository()
        mockRepository.digimonsToReturn = backupDigimons
        
        let sut = FavoritesViewModel(repository: mockRepository)
        
        sut.loadDigimons()
        sut.removeDigimon(at: 0)
        
        XCTAssertEqual(sut.getDigimons().count, 1)
        XCTAssertEqual(sut.getDigimons()[0].name, "Digimon 2")
    }
    
    func testSaveDigimonsShouldCallRepositoryWithCurrentDigimons() {
        let mockRepository = MockRepository()
        mockRepository.digimonsToReturn = backupDigimons
        
        let sut = FavoritesViewModel(repository: mockRepository)
        sut.saveDigimons()
        
        XCTAssertTrue(mockRepository.savedDigimonsCalled, "saveDigimons() deveria ter sido chamado no repositório")
        XCTAssertEqual(mockRepository.savedDigimons?.count, 2, "Deveria ter passado 2 digimons para saveDigimons")
        XCTAssertEqual(mockRepository.savedDigimons?.first?.name, "Digimon 1")
    }
}
