//
//  AccountOptionsScreen.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 15/03/2022.
//

import SwiftUI

struct AccountOptionsScreen: View {
    @State var isSingInVisible: Bool = false
    @State var isCreateAccountVisible: Bool = false
    
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
                    Text("KinemaRecord")
                        .font(.system(size: 38.0))
                        .fontWeight(.heavy)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            
            Divider()

            Button(action: {
                isSingInVisible = !isSingInVisible
            }) {
                Text("Sign in")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.init(top: 8.0, leading: 16.0, bottom: 8.0, trailing: 16.0))
                    .foregroundColor(.label)
            }
            Divider()
            
            Button(action: {
                isCreateAccountVisible = !isCreateAccountVisible
            }) {
                Text("Create account")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.init(top: 8.0, leading: 16.0, bottom: 8.0, trailing: 16.0))
                    .foregroundColor(.label)
            }

            Divider()
            
            Spacer()

        }
        .sheet(
            isPresented: $isSingInVisible,
            content: {
                LoginScreen()
            }
        )
        .sheet(
            isPresented: $isCreateAccountVisible,
            content: {
                SignupScreen()
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

