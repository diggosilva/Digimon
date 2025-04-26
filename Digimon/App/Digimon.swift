//
//  Digimon.swift
//  Digimon
//
//  Created by Diggo Silva on 23/04/25.
//

import Foundation

class Digimon: Codable, CustomStringConvertible, Hashable {
    
    let id: Int
    let name: String
    let href: String
    let image: String
    
    init(id: Int, name: String, href: String, image: String) {
        self.id = id
        self.name = name
        self.href = href
        self.image = image
    }
    
    var description: String {
        return "DIGIMON: id: \(id), nome: \(name), url: \(href), imagem: \(image)"
    }
    
    static func == (lhs: Digimon, rhs: Digimon) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.href == rhs.href &&
        lhs.image == rhs.image
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(href)
        hasher.combine(image)
    }
}
