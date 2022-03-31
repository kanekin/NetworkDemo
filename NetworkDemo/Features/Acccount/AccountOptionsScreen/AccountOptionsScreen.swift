//
//  AccountOptionsScreen.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 15/03/2022.
//

import SwiftUI

struct AccountOptionsScreen: View {
    let viewModelFactory: ViewModelFactory
    @State private var isSignInVisible: Bool = false
    @State private var isCreateAccountVisible: Bool = false
    @AppStorage("sessionId") private var sessionId: String?
    
    var body: some View {
        VStack {
            AccountOptionsView(
                isLoggedIn: Binding(
                    get: {
                        sessionId != nil
                    },
                    set: { transaction in
                        if transaction == false {
                            sessionId = nil
                        }
                    }
                ),
                onLoginPressed: {
                    isSignInVisible = true
                },
                onLogoutPressed: {
                    sessionId = nil
                })
        }
        .sheet(
            isPresented: $isSignInVisible,
            content: {
                LoginScreen(
                    viewModel: viewModelFactory.makeLoginViewModel(),
                    isPresented: $isSignInVisible
                )
            }
        ) 
    }
}


