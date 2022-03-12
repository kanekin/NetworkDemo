//
//  NetworkService.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import Foundation

class NetworkService {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    func load<T>(resource: Resource<T>) async throws -> T {
        do {
            let (data, response) = try await session.data(for: resource.request)
            
            guard let response = response as? HTTPURLResponse else {
                throw AppError.network(type: .invalidResponse)
            }

            if !(200..<300 ~= response.statusCode) {
                throw AppError.network(
                    type: .custom(
                        errorCode: response.statusCode,
                        errorDescription: HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                    )
                )
            }
            return try decoder.decode(resource.responseType, from: data)
            
        } catch {
            let error = error as NSError
            if error.domain == NSURLErrorDomain,
                error.code == NSURLErrorNotConnectedToInternet {
                throw AppError.network(type: .noInternet)
            } else if let _ = error as? DecodingError {
                throw AppError.network(type: .parsing(error: error))
            } else {
                throw AppError.network(type: .unknown)
            }
        }
    }
}
