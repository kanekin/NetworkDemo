//
//  LoginViewModel.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 24/03/2022.
//

import Foundation
import os.log
import SwiftUI

class LoginViewModel: ObservableObject {
    let networkService: NetworkServicing
    @AppStorage("sessionId") var sessionId: String?
    
    init(networkService: NetworkServicing) {
        print("initalizing LoginViewMOdel")
        self.networkService = networkService
    }
    
    func submitLogin(username: String, password: String) {
        Task {
            do {
                // Get a request token
                let tokenResponse = try await networkService.load(resource: Resources.Authentication.getRequestToken())
                guard let requestToken = tokenResponse.requestToken else { return }
                
                // Validate the request token with credentials
                let validatedTokenResponse = try await networkService.load(
                    resource: Resources.Authentication.validateRequestTokenWithLogin(
                        credentials: RequestData.Credentials(
                            username: username,
                            password: password,
                            requestToken: requestToken
                        )
                    )
                )
                guard let requestToken = validatedTokenResponse.requestToken else {
                    return
                }
                
                // Create a valid session
                let sessionResponse = try await networkService.load(resource: Resources.Authentication.createSession(requestToken: .init(requestToken: requestToken)))
                guard let success = sessionResponse.success, success, let sessionId = sessionResponse.sessionId else {
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
}
