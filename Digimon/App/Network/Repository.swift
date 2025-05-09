//
//  Repository.swift
//  Digimon
//
//  Created by Diggo Silva on 08/05/25.
//

import Foundation

protocol RepositoryProtocol {
    func getDigimons() -> [Digimon]
    func saveDigimon(_ digimon: Digimon, completion: @escaping(Result<String, DSError>) -> Void)
    func saveDigimons(_ digimons: [Digimon])
}

class Repository: RepositoryProtocol {
    let userDefaults = UserDefaults.standard
    let keyFavorites = "keyFavorites"
    
    func getDigimons() -> [Digimon] {
        if let data = userDefaults.data(forKey: keyFavorites) {
            if let decodedDigimons = try? JSONDecoder().decode([Digimon].self, from: data) {
                return decodedDigimons
            }
        }
        return []
    }
    
    func saveDigimon(_ digimon: Digimon, completion: @escaping(Result<String, DSError>) -> Void) {
        var savedDigimons = getDigimons()
        
        if savedDigimons.contains(where: { $0.id == digimon.id }) {
            completion(.failure(.digimonAlreadyExits))
            return
        }
        
        savedDigimons.append(digimon)
        
        if let encodedDigimons = try? JSONEncoder().encode(savedDigimons) {
            userDefaults.set(encodedDigimons, forKey: keyFavorites)
            completion(.success(digimon.name))
            return
        }
    }
    
    func saveDigimons(_ digimons: [Digimon]) {
        if let encodedDigimons = try? JSONEncoder().encode(digimons) {
            userDefaults.set(encodedDigimons, forKey: keyFavorites)
        }
    }
}
