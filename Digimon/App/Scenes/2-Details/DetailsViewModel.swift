//
//  DetailsViewModel.swift
//  Digimon
//
//  Created by Diggo Silva on 27/04/25.
//

import Foundation

protocol DetailsViewModelProtocol {
    func getDetailsDigimon() -> Digimon
}

class DetailsViewModel: DetailsViewModelProtocol {
    
    private let digimon: Digimon
    
    init(digimon: Digimon) {
        self.digimon = digimon
    }
    
    func getDetailsDigimon() -> Digimon {
        return digimon
    }
}
