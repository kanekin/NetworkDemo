//
//  LoginScreen].swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 15/03/2022.
//

import SwiftUI

struct LoginScreen: View {
    @State var email: String = ""
    @State var password: String = ""
    
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
                    Text("Sign in to Kinema Record")
                        .foregroundColor(.label)
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding()
                }
            
            VStack(alignment: .leading, spacing: 0.0) {
                TextField("Email", text: $email)
                    .frame(minHeight: 42.0)
                    .background(Color.systemBackground)
                    .textFieldStyle(.plain)
                Divider()
                TextField("Password", text: $password)
                    .frame(minHeight: 42.0)
                    .background(Color.systemBackground)
                    .textFieldStyle(.plain)
            }
            .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
            .background(Color.systemBackground)
            
            Button(action: {}) {
                Text("Login")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
            }
            .tint(.green)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: 5))
            .controlSize(.large)
            .padding(.init(top: 8.0, leading: 16.0, bottom: 16.0, trailing: 16.0))
            
            Spacer()
        }
        .ignoresSafeArea(edges: [.top])
        .background(Color.systemBackground)
    }
}

struct LoginScreen__Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
//            .preferredColorScheme(.dark)
    }
}
