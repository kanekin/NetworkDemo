//
//  LoginFieldsView.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 17/03/2022.
//

import SwiftUI

struct LoginFieldsView: View {
    enum Field: Hashable {
        case email
        case password
    }
    
    @State private var email: String = ""
    @State private var password: String = ""

    @FocusState private var focusedField: Field?
    let handleLogin: (String, String) -> ()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0.0) {
                Divider()
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .textContentType(.emailAddress)
                    .frame(minHeight: 42.0)
                    .background(Color.systemBackground)
                    .textFieldStyle(.plain)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .email)
                Divider()
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .frame(minHeight: 42.0)
                    .background(Color.systemBackground)
                    .textFieldStyle(.plain)
                    .submitLabel(.join)
                    .focused($focusedField, equals: .password)
                Divider()
            }
            .onSubmit {
                if email.isEmpty {
                    focusedField = .email
                } else if password.isEmpty {
                    focusedField = .password
                } else {
                    handleLogin(email, password)
                }
            }
            .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
            .background(Color.systemBackground)
        }
    }
}

struct LoginFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFieldsView(handleLogin: { _, _ in })
            .previewLayout(.sizeThatFits)
    }
}
