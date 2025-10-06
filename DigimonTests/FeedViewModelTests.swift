//
//  FeedViewModelTests.swift
//  DigimonTests
//
//  Created by Diggo Silva on 12/05/25.
//

import XCTest
import Combine
@testable import Digimon

final class DigimonTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testWhenSuccess() async {
        let mockService = MockService()
        let sut = FeedViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "State deveria ser .loaded")
        
        sut.statePublisher
            .receive(on: RunLoop.main)
            .sink { state in
                if state == .loaded {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.fetchDigimons()
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
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
    
    func testWhenFailure() async {
        let mockService = MockService()
        mockService.isSuccess = false
        let sut = FeedViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "State deveria ser .failed")
        
        sut.statePublisher
            .receive(on: RunLoop.main)
            .sink { state in
                if state == .error {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.fetchDigimons()
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertEqual(sut.numberOfItemsInSection(), 0)
    }
    
    func testWhenEmptyDigimonsList() async {
        let mockService = MockService()
        mockService.shouldReturnEmpty = true
        
        let sut = FeedViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "State deveria ser .loading e depois sair sem alterar lista")
        
        sut.statePublisher
            .receive(on: RunLoop.main)
            .sink { state in
                if state == .loading {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.fetchDigimons()
        XCTAssertEqual(sut.numberOfItemsInSection(), 0)
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
}
