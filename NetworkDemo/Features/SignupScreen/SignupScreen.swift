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
    @State var isEmailValid: Bool?
    @State var isPasswordValid: Bool?
    
    var body: some View {
        VStack(spacing: 0.0) {
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
                    Text("Join Kinema Record")
                        .foregroundColor(.label)
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding()
                }
                
                VStack(alignment: .leading, spacing: 0.0) {
                    Divider()
                    TextField("Email", text: $email, onEditingChanged: { isChanged in
                        if isChanged {
                            isEmailValid = true
                        }
                    }, onCommit: {
                        isEmailValid = textFieldValidatorEmail(email)
                    }
                    )
                        .textInputAutocapitalization(.never)
                        .textContentType(.emailAddress)
                        .frame(minHeight: 42.0)
                        .background(.background)
                        .textFieldStyle(.plain)
                    Divider()
                    SecureField("Password", text: $password, onCommit: {
                        isPasswordValid = textFieldValidatorPassword(password)
                    })
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
                    Divider()

//                    if let errorMessage = errorMessage {
//                        HStack {
//                            Image(systemName: "exclamationmark.triangle.fill")
//                                .foregroundColor(.red)
//                            Text(errorMessage)
//                                .foregroundColor(.red)
//                                .font(.system(size: 14.0))
//                                .padding(.init(top: 8.0, leading: 0.0, bottom: 8.0, trailing: 0.0))
//                        }
//                    }
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
        .ignoresSafeArea(edges: [.top])
        .background(Color.systemBackground)
    }
    
    private func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
//        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    private func textFieldValidatorPassword(_ string: String) -> Bool {
        return string.count > 8 && string.count < 16
    }
    
    private func submit() {
        
    }
}

struct SignupScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignupScreen(
//            errorMessage: "Something is wrong"
        )
//            .preferredColorScheme(.dark)

    }
}
