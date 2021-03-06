//
//  LoginViewModel.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 24/03/2022.
//

import Foundation
import os.log
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    private let loginNetworkHandler: LoginNetworkHandling
    private let sessionStorage: SessionStoring
    @Published var errorMessage: String?
    private var appState: AppState?
    
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
    
    func set(appState: AppState) {
        self.appState = appState
    }
     
    func submitLogin(username: String, password: String) async {
        do {
            // Get a request token
            let tokenResponse = try await loginNetworkHandler.getRequestToken()
            guard let success = tokenResponse.success, success,
                  let requestToken = tokenResponse.requestToken else {
                      Logger.network.error("Failed to get a request token")
                      errorMessage = "Login failed"
                      return
                  }
            
            // Validate the request token with credentials
            let validatedTokenResponse = try await loginNetworkHandler.validateToken(username: username, password: password, token: requestToken)
            guard let success = tokenResponse.success, success,
                  let requestToken = validatedTokenResponse.requestToken else {
                      Logger.network.error("Failed to validate the request token")
                      errorMessage = "Login failed"
                      return
                  }
            
            // Create a valid session
            let sessionResponse = try await loginNetworkHandler.createSession(token: requestToken)
            guard let success = sessionResponse.success,
                    success,
                    let sessionId = sessionResponse.sessionId else {
                Logger.network.debug("Failed to create a valid session ID")
                errorMessage = "Login failed"
                return
            }
            
            // Store Session Id
            self.sessionId = sessionId
            appState?.isLoggedIn = true
            
        } catch {
            Logger.network.error("Error during submitting login: \(error.localizedDescription)")
            guard let appError = error as? AppError else { return }
            
            switch appError {
            case let .network(type: type):
                handleNetworkError(type: type)
            case .custom:
                errorMessage = "Login failed"
            }
        }
    }
    
    private func handleNetworkError(type: AppError.Enums.NetworkError) {
        switch type {
        case .invalidResponse:
            // Unrecoverable from the client side. Should notify remote logging.
            errorMessage = "Login failed"
        case .noInternet:
            // Recoverable by the user or the client
            errorMessage = "No Internet"
        case .parsing(error: let error):
            // Unrecoverable from the client side. Should notify remote logging.
            Logger.network.error("Parsing error: \(error.localizedDescription)")
            errorMessage = "Login failed"
        case .unauthenticated:
            // Recoverable by the user
            errorMessage = "Incorrect username and password"
        case .custom(errorCode: let errorCode, errorDescription: _):
            // Unrecoverable. Could implement more distincition based on error code
            errorMessage = "Login failed"
        case .unknown(error: let error):
            // Unrecoverable. Should notify remote logger.
            Logger.network.error("Unknown error: \(error.map { $0.localizedDescription } ?? "")")
            errorMessage = "Login failed"
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
