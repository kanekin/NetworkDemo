//
//  Resources.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import Foundation

struct Resources {
    struct Movie {
        static func getPopular() -> Resource<DataModel.Movies> {
            return .init(
                url: .init(fromTMDBPath: "/3/movie/popular")!,
                httpMethod: .get
            )
        }
        
        static func getDetails(id: Int) -> Resource<DataModel.Movie.Details> {
            return .init(
                url: .init(fromTMDBPath: "/3/movie/\(id)")!,
                httpMethod: .get
            )
        }
        
        static func getCredits(id: Int) -> Resource<DataModel.Movie.Credits> {
            return .init(
                url: .init(fromTMDBPath: "/3/movie/\(id)/credits")!,
                httpMethod: .get
            )
        }
    }
}

extension URL {
    init?(fromTMDBPath path: String) {
        guard var urlComponents = URLComponents(string: ApiConstants.baseUrl) else { return nil }
        urlComponents.path = path
        urlComponents.queryItems = [ URLQueryItem(name: "api_key", value: String(ApiConstants.apiKey)) ]
        
        guard let url = urlComponents.url else { return nil }
        self = url
    }
}
