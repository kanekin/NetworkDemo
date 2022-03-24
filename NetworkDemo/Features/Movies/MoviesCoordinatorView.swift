//
//  MoviesCoordinatorView.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 24/03/2022.
//

import SwiftUI

struct MoviesCoordinatorView: View {
    @ObservedObject var coordinator: MoviesCoordinator
    
    var body: some View {
        NavigationView {
            VStack {
                MovieListScreen(viewModel: coordinator.movieListViewModel)
                
                NavigationLink(
                    isActive: Binding(
                        get: {
                            coordinator.selectedMovieDetailsViewModel != nil
                        },
                        set: { value in
                            if value == false {
                                coordinator.selectedMovieDetailsViewModel = nil
                            }
                        }),
                    destination: {
                        coordinator.selectedMovieDetailsViewModel.map { viewModel in
                            MovieDetailsScreen(viewModel: viewModel)
                        }
                    },
                    label: { EmptyView() }
                )
            }
        }
    }
}
