//
//  LoginScreen].swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 15/03/2022.
//

import SwiftUI
import os.log

struct LoginScreen: View {
    let viewModel: LoginViewModel
    @Binding var isPresented: Bool
    @AppStorage("sessionId") var sessionId: String?

    var body: some View {
        VStack {
            if sessionId == nil {
                LoginView(submitLogin: { username, password in
                    Task {
                        await viewModel.submitLogin(username: username, password: password)
                    }
                })
            } else {
                LoginSuccessView(onAnimationCompleted: {
                    isPresented = false
                })
            }
        }
        .ignoresSafeArea(edges: [.top])
        .background(Color.systemBackground)
    }
}

