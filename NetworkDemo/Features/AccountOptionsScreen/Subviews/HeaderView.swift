//
//  HeaderView.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 23/03/2022.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
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
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(.sizeThatFits)
    }
}
