//
//  DetailsResponse.swift
//  Digimon
//
//  Created by Diggo Silva on 30/04/25.
//

import Foundation

struct DetailsResponse: Codable {
    let id: Int
    let name: String
    let images: [Image]
    let fields: [Field]
    let descriptions: [Description]
    let priorEvolutions, nextEvolutions: [Evolution]

    struct Description: Codable {
        let origin, language, description: String
    }

    struct Field: Codable {
        let id: Int
        let field: String
        let image: String
    }

    struct Image: Codable {
        let href: String
        let transparent: Bool
    }

    struct Evolution: Codable {
        let id: Int
        let digimon, condition: String
        let image: String
        let url: String
    }
}
