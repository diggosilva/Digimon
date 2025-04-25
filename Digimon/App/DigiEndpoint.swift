//
//  DigiEndpoint.swift
//  Digimon
//
//  Created by Diggo Silva on 24/04/25.
//

import Foundation

enum DigiEndpoint {
    case digimons
    case pagedDigimons(page: Int)
    case digimonId(id: Int)
    
    var path: String {
        switch self {
        case .digimons:
            return "/api/v1/digimon"
            
        case .pagedDigimons:
            return "/api/v1/digimon"
            
        case .digimonId(let id):
            return "/api/v1/digimon/\(id)"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .digimons:
            return nil
            
        case .pagedDigimons(let page):
            return [URLQueryItem(name: "page", value: "\(page)")]
            
        case .digimonId:
            return nil
        }
    }
}
