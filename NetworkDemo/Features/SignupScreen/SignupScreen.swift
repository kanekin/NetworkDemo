//
//  SignupScreen.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 15/03/2022.
//

import SwiftUI

struct SignupScreen: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var agreeToTermsOfUse = false
    @State var agreeToPrivacyPolicy = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text("Join Kinema Record")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 0.0) {
                    TextField("Email", text: $email)
                        .frame(minHeight: 42.0)
                        .background(.background)
                        .textFieldStyle(.plain)
                    Divider()
                    SecureField("Password", text: $password)
                        .frame(minHeight: 42.0)
                        .background(.background)
                        .textFieldStyle(.plain)
                    Divider()
                    Toggle("I'm at least 16 years old and accept Terms of Use.", isOn: $agreeToTermsOfUse)
                        .font(.system(size: 14.0))
                        .foregroundColor(.secondaryLabel)
                        .padding(.init(top: 6.0, leading: 0.0, bottom: 6.0, trailing: 0.0))
                    Divider()
                    Toggle("I have read and accept the Privacy Policy.", isOn: $agreeToPrivacyPolicy)
                        .font(.system(size: 14.0))
                        .foregroundColor(.secondaryLabel)
                        .padding(.init(top: 6.0, leading: 0.0, bottom: 6.0, trailing: 0.0))
                }
                .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                .background(Color.systemBackground)
                
                Button(action: {}) {
                    Text("Join")
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
            .background {
                Image("OneFlewOverTheCuckoosNest")
                    .resizable()
                    .clipped()
                    .aspectRatio(contentMode: .fill)
                    .overlay {
                        LinearGradient(gradient: Gradient(colors: Color.gradientFromCenter), startPoint: .top, endPoint: .bottom)
                    }
            }
        }
        .ignoresSafeArea(edges: [.top])
        .background(Color.black)
    }
}

struct SignupScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignupScreen()
            .preferredColorScheme(.dark)

    }
}
