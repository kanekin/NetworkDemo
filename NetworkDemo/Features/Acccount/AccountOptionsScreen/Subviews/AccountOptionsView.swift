//
//  LoginView.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 23/03/2022.
//

import SwiftUI

struct AccountOptionsView: View {
    @Binding var isLoggedIn: Bool
    let onLoginPressed: () -> ()
    let onLogoutPressed: () -> ()
    
    var body: some View {
        VStack {
            HeaderView()
            if isLoggedIn {
                Divider()
                Button(action: onLogoutPressed) {
                    Text("Sign out")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.init(top: 8.0, leading: 16.0, bottom: 8.0, trailing: 16.0))
                        .foregroundColor(.label)
                }
                Divider()
            } else {
                Divider()
                Button(action: onLoginPressed) {
                    Text("Sign in")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.init(top: 8.0, leading: 16.0, bottom: 8.0, trailing: 16.0))
                        .foregroundColor(.label)
                }
                Divider()
            }
            Spacer()
        }
        .ignoresSafeArea(edges: [.top])
    }
}

struct AccountOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountOptionsView(
            isLoggedIn: .constant(false)
            ,
            onLoginPressed: {},
            onLogoutPressed: {}
        )
        
        AccountOptionsView(
            isLoggedIn: .constant(true),
            onLoginPressed: {},
            onLogoutPressed: {}
        )
            .preferredColorScheme(.dark)
    }
}
