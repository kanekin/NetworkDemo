//
//  SubmitRatingView.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 14/03/2022.
//

import SwiftUI

struct SubmitRateButtonView: View {
    let onPressed: () -> ()
    
    var body: some View {
        Button(
            action: {
                onPressed()
            },
            label: {
                VStack(alignment: .leading) {
                    Divider()
                    HStack {
                        Text("Submit your rating")
                    }
                    .padding(.init(top: 8.0, leading: 0.0, bottom: 8.0, trailing: 0.0))
                    Divider()
                }
            }
        )
    }
}

struct SubmitRatingView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitRateButtonView(onPressed: {})
            .previewLayout(.sizeThatFits)
    }
}
