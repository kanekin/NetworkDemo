//
//  LoginScreen].swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 15/03/2022.
//

import SwiftUI
import os.log

struct LoginScreen: View {
    @ObservedObject var viewModel: LoginViewModel
    @Binding var isPresented: Bool
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            if viewModel.sessionId == nil {
                LoginView(
                    submitLogin: { username, password in
                        Task {
                            await viewModel.submitLogin(username: username, password: password)
                        }
                    },
                    errorMessage: $viewModel.errorMessage
                )
            } else {
                LoginSuccessView(onAnimationCompleted: {
                    isPresented = false
                })
            }
        }
        .onAppear(perform: { viewModel.set(appState: appState) })
        .ignoresSafeArea(edges: [.top])
        .background(Color.systemBackground)
    }
}

