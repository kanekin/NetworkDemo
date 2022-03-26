//
//  MovieDetailScreen.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 12/03/2022.
//

import SwiftUI
import Combine

struct MovieDetailsScreen: View {
    
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    
    var body: some View {
        MovieDetailsView(
            details: viewModel.movieDetails,
            credits: $viewModel.credits,
            onSubmitRating: { rating in
                Task {
                    await viewModel.submitRating(rating, for: viewModel.id)
                }
            }
        )
            .onAppear {
                print("onAppear")
                Task {
                    await viewModel.load()
                    
                }
            }
            .onDisappear(perform: {
                print("onDisappear")
            })
            .edgesIgnoringSafeArea(.top)
            .navigationBarDisplayChevronBackButton()
    }
}
