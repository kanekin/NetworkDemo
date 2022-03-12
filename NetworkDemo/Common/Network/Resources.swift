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
            var urlComponents = URLComponents(string: ApiConstants.baseUrl)!
            urlComponents.path = "/3/movie/popular"
            urlComponents.queryItems = [ URLQueryItem(name: "api_key", value: String(ApiConstants.apiKey)) ]
            return Resource<DataModel.Movies>(
                url: urlComponents.url!,
                httpMethod: .get
            )
        }
        
        static func getDetails(id: Int) -> Resource<DataModel.Movie.Details> {
            var urlComponents = URLComponents(string: ApiConstants.baseUrl)!
            urlComponents.path = "/3/movie/\(id)"
            urlComponents.queryItems = [ URLQueryItem(name: "api_key", value: String(ApiConstants.apiKey)) ]
            return Resource<DataModel.Movie.Details>(
                url: urlComponents.url!,
                httpMethod: .get
            )
        }
    }
}
