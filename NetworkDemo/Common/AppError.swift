//
//  AppError.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import Foundation

enum AppError {
    case network(type: Enums.NetworkError)
    case custom(errorDescription: String?)

    class Enums { }
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .network(let type): return type.localizedDescription
            case .custom(let errorDescription): return errorDescription
        }
    }
}

extension AppError.Enums {
    enum NetworkError {
        case invalidResponse
        case noInternet
        case unauthenticated
        case parsing(error: Error)
        case custom(errorCode: Int?, errorDescription: String?)
        case unknown(error: Error?)
    }
}

extension AppError.Enums.NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .noInternet: return "No Internet"
            case .invalidResponse: return "Invalid response"
            case .unauthenticated: return "Unauthenticated User"
            case .parsing(let error): return "Parsing error: \(error)"
            case .custom(_, let errorDescription): return errorDescription
            case .unknown(let error): return "Unknown error: \(error?.localizedDescription ?? "")"
        }
    }

    var errorCode: Int? {
        switch self {
            case .noInternet: return nil
            case .invalidResponse: return nil
            case .unauthenticated: return nil
            case .parsing: return nil
            case .custom(let errorCode, _): return errorCode
            case .unknown: return nil
        }
    }
}
