//
//  AccountOptionsScreen.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 15/03/2022.
//

import SwiftUI

struct AccountOptionsScreen: View {
    @State var isSignInVisible: Bool = false
    @State var isCreateAccountVisible: Bool = false
    @AppStorage("sessionId") var sessionId: String?
    
    var body: some View {
        VStack {
            HeaderView()
            
            AccountOptionsView(
                isLoggedIn: Binding(get: {
                    sessionId != nil
                }, set: { transaction in
                    if transaction == false {
                        sessionId = nil
                    }
                }),
                onLoginPressed: {
                    isSignInVisible = true
                },
                onLogoutPressed: {
                    sessionId = nil
                })
            
            Spacer()
        }
        .sheet(
            isPresented: $isSignInVisible,
            content: {
                LoginScreen(
                    networkService: .init(session: URLSession.shared, decoder: JSONDecoder()),
                    isPresented: $isSignInVisible)
            }
        )
        .ignoresSafeArea(edges: [.top])
    }
}

struct AccountOptionsScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountOptionsScreen()
        AccountOptionsScreen()
            .preferredColorScheme(.dark)
    }
}

