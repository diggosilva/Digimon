//
//  DigimonResponse.swift
//  Digimon
//
//  Created by Diggo Silva on 23/04/25.
//

import Foundation

struct DigimonResponse: Codable {
    
    let content: [Content]
    let pageable: Pageable
    
    struct Content: Codable {
        let id: Int
        let name: String
        let href: String
        let image: String
    }
    
    struct Pageable: Codable {
        let currentPage, elementsOnPage, totalElements, totalPages: Int
        let previousPage: String
        let nextPage: String
    }
}
