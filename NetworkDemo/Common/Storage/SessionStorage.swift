//
//  SessionStorage.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 26/03/2022.
//

import Foundation
import SwiftKeychainWrapper

protocol SessionStoring {
    var sessionId: String? { get }
    func setSession(id: String?)
}


class SessionStorage: SessionStoring {
    static let shared: SessionStorage = SessionStorage()
    private static let sessionIdKey = "sessionId"
    
    var sessionId: String? {
        get {
            KeychainWrapper.standard.string(forKey: SessionStorage.sessionIdKey)
        }
    }
    
    func setSession(id: String?) {
        guard let id = id else {
            KeychainWrapper.standard.removeObject(forKey: SessionStorage.sessionIdKey)
            return
        }
        KeychainWrapper.standard.set(id, forKey: SessionStorage.sessionIdKey)
    }
}
