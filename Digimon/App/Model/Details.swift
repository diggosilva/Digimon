//
//  Details.swift
//  Digimon
//
//  Created by Diggo Silva on 02/05/25.
//

import Foundation

class Details: Codable, CustomStringConvertible {
    let id: Int
    let name: String
    let digiDescriptions: String
    
    init(id: Int, name: String, digiDescriptions: String) {
        self.id = id
        self.name = name
        self.digiDescriptions = digiDescriptions
    }
    
    var description: String {
        return " Details: ID: \(id), Name: \(name), Descriptions: \(digiDescriptions)"
    }
}
