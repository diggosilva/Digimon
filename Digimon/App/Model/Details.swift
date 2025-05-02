//
//  Details.swift
//  Digimon
//
//  Created by Diggo Silva on 02/05/25.
//

import Foundation

class Details: CustomStringConvertible {
    let id: Int
    let name: String
    let imageURLs: [String]
    let fieldNames: [String]
    let descriptions: String
    let priorEvolutions: [String]
    let nextEvolutions: [String]
    
    init(from response: DetailsResponse) {
        self.id = response.id
        self.name = response.name
        self.imageURLs = response.images.map { $0.href }
        self.fieldNames = response.fields.map { $0.field }
        self.descriptions = response.descriptions.first { $0.language == "en_us" }?.description ?? "No English description available"
        self.priorEvolutions = response.priorEvolutions.map { $0.digimon }
        self.nextEvolutions = response.nextEvolutions.map { $0.digimon }
    }
    
    var description: String {
        return """
        Details:
        Name: \(name)
        Images: \(imageURLs.joined(separator: ", "))
        Fields: \(fieldNames.joined(separator: ", "))
        Descriptions: \(descriptions)
        Prior Evolutions: \(priorEvolutions.joined(separator: ", "))
        Next Evolutions: \(nextEvolutions.joined(separator: ", "))
        """
    }
}
