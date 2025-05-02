//
//  Service.swift
//  Digimon
//
//  Created by Diggo Silva on 20/04/25.
//

import Foundation

protocol ServiceProtocol {
    func getDigimons(page: Int, completion: @escaping(Result<[Digimon], DSError>) -> Void)
    func getDetails(of digimon: Digimon, completion: @escaping(Result<Details, DSError>) -> Void)
}

final class Service: ServiceProtocol {
    
    func getDigimons(page: Int, completion: @escaping(Result<[Digimon], DSError>) -> Void) {
        fetchData(endpoint: .pagedDigimons(page: page), decondingType: DigimonResponse.self) { result in
            switch result {
            case .success(let digimonsResponse):
                let digimons = digimonsResponse.content.map { content in
                    Digimon(id: content.id, name: content.name, href: content.href, image: content.image)
                }
                completion(.success(digimons))
                
            case .failure(_):
                completion(.failure(.digimonsFailed))
            }
        }
    }
    
    func getDetails(of digimon: Digimon, completion: @escaping(Result<Details, DSError>) -> Void) {
        fetchData(endpoint: .digimonId(id: digimon.id), decondingType: DetailsResponse.self) { result in
            switch result {
            case .success(let detailsResponse):
                let details = Details(from: detailsResponse)
                completion(.success(details))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchData<T: Decodable>(endpoint: DigiEndpoint, decondingType: T.Type, completion: @escaping(Result<T, DSError>) -> Void) {
        guard let url = createURL(for: endpoint) else {
            completion(.failure(.invalidData))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(.networkError))
                    return
                }
                
                guard response is HTTPURLResponse else {
                    completion(.failure(.networkError))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(decondingType, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(.failedDecoding))
                }
            }
        }
        task.resume()
    }
    
    private func createURL(for endpoint: DigiEndpoint) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "digi-api.com"
        urlComponents.path = endpoint.path
        
        if let queryItems = endpoint.queryItems { urlComponents.queryItems = queryItems }
        
        print("DEBUG: URL: \(String(describing: urlComponents.url))")
        return urlComponents.url
    }
}
