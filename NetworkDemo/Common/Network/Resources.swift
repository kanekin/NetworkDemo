//
//  Resources.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import Foundation

struct Resources {
    struct Movies {
        static func getPopular() -> Resource<DataModel.Movies> {
            var urlComponents = URLComponents(string: ApiConstants.baseUrl)!
            urlComponents.path = "/3/movie/popular"
            urlComponents.queryItems = [ URLQueryItem(name: "api_key", value: String(ApiConstants.apiKey)) ]
            return Resource<DataModel.Movies>(
                url: urlComponents.url!,
                httpMethod: .get
            )
        }
    }
}
