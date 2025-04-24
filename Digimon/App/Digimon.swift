//
//  Digimon.swift
//  Digimon
//
//  Created by Diggo Silva on 23/04/25.
//

import Foundation

class Digimon: Codable, CustomStringConvertible {
    
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
}
