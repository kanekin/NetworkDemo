//
//  AverageRateView.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 14/03/2022.
//

import SwiftUI

struct AverageRateView: View {
    let voteAverage: Double?
    
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            Text(voteAverage.map { String.init(format: "%.1f", $0) } ?? "?" ) 
                .fontWeight(.semibold)
        }
    }
}

struct AverageRateView_Previews: PreviewProvider {
    static var previews: some View {
        AverageRateView(voteAverage: 4.8)
            .previewLayout(.sizeThatFits)
    }
}
