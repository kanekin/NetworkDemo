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
            credits: $viewModel.credits
        )
            .onAppear {
                Task {
                    await viewModel.load()
                    
                }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarDisplayChevronBackButton()
    }
}
