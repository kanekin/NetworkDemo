//
//  SessionStorage.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 26/03/2022.
//

import Foundation

protocol SessionStoring {
    var sessionId: String? { get }
    func setSession(id: String?)
}


class SessionStorage: SessionStoring {
    static let shared: SessionStorage = SessionStorage()
    private static let sessionIdKey = "sessionId"
    
    var sessionId: String? {
        get {
            UserDefaults.standard.string(forKey: SessionStorage.sessionIdKey)
        }
    }
    
    func setSession(id: String?) {
        UserDefaults.standard.set(id, forKey: SessionStorage.sessionIdKey)
    }
}
