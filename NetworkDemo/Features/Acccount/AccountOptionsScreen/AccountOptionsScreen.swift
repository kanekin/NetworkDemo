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
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            AccountOptionsView(
                isLoggedIn: $appState.isLoggedIn,
                onLoginPressed: {
                    isSignInVisible = true
                },
                onLogoutPressed: {
                    appState.isLoggedIn = false
                    SessionStorage().setSession(id: nil)
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
