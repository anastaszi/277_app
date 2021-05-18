//
//  NetworkErrors.swift
//  FashionTrends (iOS)
//
//  Created by Anastasia Zimina on 5/17/21.
//

import Foundation

enum APIErrors: Int, Error {
    case badRequest = 400
    case unAuthorized = 401
    case serverError = 500
    
    var errorDescription: String? {
        switch self {
        case .serverError:
            return "Server error"
        default:
            return "Something goes wrong."
        }
    }
}

enum APIProviderError: Error {
    case invalidURL
    case dataNil
    case decodingError
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .dataNil:
            return "Empty Data"
        case .decodingError:
            return "Data has invalid format"
        default:
            return "Something went wrong"
        }
    }
    
}
