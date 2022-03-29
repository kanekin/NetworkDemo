//
//  NavigationChevronBackButtonModifier.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 24/03/2022.
//

import SwiftUI

extension View {
    func navigationBarDisplayChevronBackButton() -> some View {
        return modifier(NavigationChevronBackButtonModifier())
    }
}

struct NavigationChevronBackButtonModifier: ViewModifier {
    
    @Environment(\.presentationMode) var presentation
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Button(
                    action: { presentation.wrappedValue.dismiss() },
                    label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .imageScale(.large)
                    }
                )
            )
            .gesture(
                DragGesture(coordinateSpace: .local)
                    .onEnded({ value in
                        if value.translation.width > .zero
                            && value.translation.height > -30
                            && value.translation.height < 30 {
                            presentation.wrappedValue.dismiss()
                        }
                    })
            )
    }
}

