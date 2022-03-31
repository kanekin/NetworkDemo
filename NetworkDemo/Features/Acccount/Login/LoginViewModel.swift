//
//  LoginViewModel.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 24/03/2022.
//

import Foundation
import os.log

class LoginViewModel: ObservableObject {
    let loginNetworkHandler: LoginNetworkHandling
    let sessionStorage: SessionStoring
    
    @Published var sessionId: String? {
        didSet {
            sessionStorage.setSession(id: sessionId)
        }
    }
    
    init(loginNetworkHandler: LoginNetworkHandling, sessionStorage: SessionStoring) {
        self.loginNetworkHandler = loginNetworkHandler
        self.sessionStorage = sessionStorage
        self.sessionId = sessionStorage.sessionId
    }
    
    
    func submitLogin(username: String, password: String) async {
        do {
            // Get a request token
            let tokenResponse = try await loginNetworkHandler.getRequestToken()
            guard let requestToken = tokenResponse.requestToken else { return }
            
            // Validate the request token with credentials
            let validatedTokenResponse = try await loginNetworkHandler.validateToken(username: username, password: password, token: requestToken)
            guard let requestToken = validatedTokenResponse.requestToken else {
                return
            }
            
            // Create a valid session
            let sessionResponse = try await loginNetworkHandler.createSession(token: requestToken)
            guard let success = sessionResponse.success,
                    success,
                    let sessionId = sessionResponse.sessionId else {
                Logger.network.debug("Failed to create a valid session ID")
                return
            }
            
            // Store Session Id
            self.sessionId = sessionId
            // Dismiss the screen
        } catch {
            Logger.network.debug("Error during submitting login: \(error.localizedDescription)")
        }
    }
}

protocol LoginNetworkHandling {
    func getRequestToken() async throws -> DataModel.Authentication.Token
    func validateToken(username: String, password: String, token: String) async throws -> DataModel.Authentication.Token
    func createSession(token: String) async throws -> DataModel.Authentication.Session
}

class LoginNetworkHandler: LoginNetworkHandling {
    let networkService: NetworkServicing
    
    init(networkService: NetworkServicing) {
        self.networkService = networkService
    }
    
    func getRequestToken() async throws -> DataModel.Authentication.Token {
        return try await networkService.load(resource: Resources.Authentication.getRequestToken())
    }
    
    func validateToken(username: String, password: String, token: String) async throws -> DataModel.Authentication.Token {
        return try await networkService.load(
            resource: Resources.Authentication.validateRequestTokenWithLogin(
                credentials: RequestData.Credentials(
                    username: username,
                    password: password,
                    requestToken: token
                )
            )
        )
    }
    
    func createSession(token: String) async throws -> DataModel.Authentication.Session {
        return try await networkService.load(
            resource: Resources.Authentication.createSession(requestToken: .init(requestToken: token))
        )
    }
}
