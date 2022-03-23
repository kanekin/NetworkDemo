//
//  Resource.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import Foundation

enum HTTPMethod {
    case get
    case post(Encodable)
    case put(Encodable)
    case patch(Encodable)
    case delete
}

extension HTTPMethod {
    var string: String {
        switch self {
        case .get: return "get"
        case .post: return "post"
        case .put: return "put"
        case .patch: return "patch"
        case .delete: return "delete"
        }
    }
}

struct Resource<T: Decodable> {
    let request: URLRequest
    let responseType: T.Type
}

extension Resource where T: Decodable {
    init(url: URL, httpMethod: HTTPMethod) {
        var urlRequest: URLRequest {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = httpMethod.string
            
            if case let .post(body) = httpMethod {
                urlRequest.httpBody = body.toJSONData()
                urlRequest.allHTTPHeaderFields = [
                    "Content-Type": "application/json"
                ]
            }
            return urlRequest
        }
                
        self.request = urlRequest
        self.responseType = T.self
    }
}

extension Encodable {
    func toJSONData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
