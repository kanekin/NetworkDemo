//
//  Resources.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import Foundation

struct Resources {
    
    struct Authentication {
        static func getRequestToken() -> Resource<DataModel.Authentication.Token> {
            return .init(
                url: .init(fromTMDBPath: "/3/authentication/token/new")!,
                httpMethod: .get
            )
        }
        
        static func validateRequestTokenWithLogin(credentials: RequestData.Credentials) -> Resource<DataModel.Authentication.Token> {
            return .init(
                url: .init(fromTMDBPath: "/3/authentication/token/validate_with_login")!,
                httpMethod: .post(credentials)
            )
        }
        
        static func createSession(requestToken: RequestData.RequestToken) -> Resource<DataModel.Authentication.Session> {
            return .init(
                url: .init(fromTMDBPath: "/3/authentication/session/new")!,
                httpMethod: .post(requestToken)
            )
        }
    }
    
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
