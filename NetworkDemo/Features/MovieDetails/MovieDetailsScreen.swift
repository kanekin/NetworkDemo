//
//  MovieDetailScreen.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 12/03/2022.
//

import SwiftUI
import Combine

struct MovieDetailsScreen: View {
    
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        MovieDetailsView(movie: viewModel.movieDetails)
            .onAppear {
                viewModel.load()
            }
            .navigationTitle(viewModel.movieDetails?.title ?? "")
            .navigationBarTitleDisplayMode(.inline)
            
    }
}
