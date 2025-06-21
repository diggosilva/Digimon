//
//  Service.swift
//  Digimon
//
//  Created by Diggo Silva on 20/04/25.
//

import Foundation

protocol ServiceProtocol {
    func getDigimons(page: Int) async throws -> [Digimon]
    func getDetails(of digimon: Digimon) async throws -> Details
}

final class Service: ServiceProtocol {
    func getDigimons(page: Int) async throws -> [Digimon] {
        let digimonsResponse: DigimonResponse = try await fetchData(endpoint: .pagedDigimons(page: page), decodingType: DigimonResponse.self)
        
        return digimonsResponse.content.map { content in
            Digimon(id: content.id, name: content.name, href: content.href, image: content.image)
        }
    }
    
    func getDetails(of digimon: Digimon) async throws -> Details {
        let detailsResponse: DetailsResponse = try await fetchData(endpoint: .digimonId(id: digimon.id), decodingType: DetailsResponse.self)
        
        return Details(
            id: detailsResponse.id,
            name: detailsResponse.name,
            digiDescriptions: detailsResponse.descriptions.first(where: { $0.language == "en_us" })?.description ?? ""
        )
    }
    
    private func fetchData<T: Decodable>(endpoint: DigiEndpoint, decodingType: T.Type) async throws -> T {
        guard let url = createURL(for: endpoint) else {
            throw DSError.invalidData
        }
        
        let (data, response): (Data, URLResponse)
        
        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            throw DSError.networkError
        }
        
        guard (response as? HTTPURLResponse) != nil else {
            throw DSError.networkError
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw DSError.failedDecoding
        }
    }
    
    private func createURL(for endpoint: DigiEndpoint) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "digi-api.com"
        urlComponents.path = endpoint.path
        
        if let queryItems = endpoint.queryItems {
            urlComponents.queryItems = queryItems
        }
        
        print("DEBUG: URL: \(String(describing: urlComponents.url))")
        return urlComponents.url
    }
}
