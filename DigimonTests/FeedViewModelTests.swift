//
//  DigimonTests.swift
//  DigimonTests
//
//  Created by Diggo Silva on 12/05/25.
//

import XCTest
@testable import Digimon

class MockFeedViewModel: FeedViewModelProtocol {
    func numberOfItemsInSection() -> Int {
        <#code#>
    }
    
    func cellForItem(at indexPath: IndexPath) -> Digimon {
        <#code#>
    }
    
    func searchBar(textDidChange searchText: String) {
        <#code#>
    }
    
    func fetchDigimons() {
        <#code#>
    }
    
    func getDigimons() -> [Digimon] {
        <#code#>
    }
    
    func observeState(_ observer: @escaping (FeedViewControllerStates) -> Void) {
        <#code#>
    }
}

final class DigimonTests: XCTestCase {
    
    
    
}
