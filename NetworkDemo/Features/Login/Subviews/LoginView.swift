//
//  LoginView.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 23/03/2022.
//

import SwiftUI

struct LoginView: View {
    let submitLogin: (String, String) -> ()
    
    var body: some View {
        VStack {
            Image("OneFlewOverTheCuckoosNest")
                .resizable()
                .clipped()
                .aspectRatio(contentMode: .fill)
                .frame(height: 350, alignment: .bottom)
                .clipped()
                .overlay {
                    LinearGradient(gradient: Gradient(colors: Color.backgroundGradient), startPoint: .top, endPoint: .bottom)
                }
                .overlay {
                    Text("Sign in to KinemaRecord")
                        .foregroundColor(.label)
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding()
                }
            LoginFieldsView(handleLogin: { username, password in
                submitLogin(username, password)
            })
            
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            submitLogin: { _,_ in }
        )
    }
}
