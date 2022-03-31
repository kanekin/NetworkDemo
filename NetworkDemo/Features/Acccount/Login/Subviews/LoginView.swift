//
//  LoginView.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 23/03/2022.
//

import SwiftUI

struct LoginView: View {
    let submitLogin: (String, String) -> ()
    @Binding var errorMessage: String?
    
    var body: some View {
        VStack(alignment: .leading) {
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
            LoginFieldsView(
                handleLogin: { username, password in
                    submitLogin(username, password)
                }
            )
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            submitLogin: { _,_ in }, errorMessage: .constant(nil)
        )
    }
}
