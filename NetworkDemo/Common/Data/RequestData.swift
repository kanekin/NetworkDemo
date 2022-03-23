//
//  RequestData.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 17/03/2022.
//

import Foundation

struct RequestData {
    struct Credentials: Encodable {
        let username: String
        let password: String
        let requestToken: String
        
        enum CodingKeys: String, CodingKey {
            case username
            case password
            case requestToken = "request_token"
        }
    }
    
    struct RequestToken: Encodable {
        let requestToken: String
        
        enum CodingKeys: String, CodingKey {
            case requestToken = "request_token"
        }
    }
}

