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
                LoginView(submitLogin: viewModel.submitLogin)
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

//struct LoginScreen__Previews: PreviewProvider {
//    static var previews: some View {
//        LoginScreen(
//            viewModel: vieMo,
//            isPresented: .constant(true)
//        )
////            .preferredColorScheme(.dark)
//    }
//}
