//
//  LoginScreen].swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 15/03/2022.
//

import SwiftUI
import os.log

struct LoginScreen: View {
    
    let networkService: NetworkService
    @Binding var isPresented: Bool
    @AppStorage("sessionId") var sessionId: String?

    var body: some View {
        VStack {
            if sessionId == nil {
                LoginView(submitLogin: submitLogin(username:password:))
            } else {
                LoginSuccessView(onAnimationCompleted: {
                    isPresented = false
                })
            }
        }
        .ignoresSafeArea(edges: [.top])
        .background(Color.systemBackground)
    }
    
    private func submitLogin(username: String, password: String) {
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

struct LoginScreen__Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(
            networkService: NetworkService(session: URLSession.shared, decoder: JSONDecoder()),
            isPresented: .constant(true)
        )
//            .preferredColorScheme(.dark)
    }
}
