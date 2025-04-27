//
//  DSError.swift
//  Digimon
//
//  Created by Diggo Silva on 24/04/25.
//

import Foundation

enum DSError: String, Error {
    case networkError = "Não foi possível conectar ao servidor. Verifique sua conexão de internet."
    case invalidData = "Os dados recebidos do servidor são inválidos. Tente novamente."
    case failedDecoding = "Não foi possível decodificar os dados."
    case digimonsFailed = "Não foi possível carregar os digimons."
}
