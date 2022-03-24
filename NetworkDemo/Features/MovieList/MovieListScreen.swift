//
//  MovieListView.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import SwiftUI

struct MovieListScreen: View {
   
    @ObservedObject var viewModel: MovieListViewModel
    @State var selection: Int?
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.movies) { movie in
                    Button(action: {
                        viewModel.selectMovie(id: movie.id)
                    }, label: {
                        MovieListCell(movie: movie)
                    })
                }
                
                NavigationLink(
                    isActive: Binding(
                        get: {
                            viewModel.selectedMovieDetailsViewModel != nil
                        },
                        set: { value in
                            if value == false {
                                viewModel.selectedMovieDetailsViewModel = nil
                            }
                        }),
                    destination: {
                        viewModel.selectedMovieDetailsViewModel.map { viewModel in
                            MovieDetailsScreen(viewModel: viewModel)
                        }
                    },
                    label: { EmptyView() }
                )
            }

            .listStyle(.plain)
            .navigationTitle("Popular Films")
            .onAppear {
                viewModel.load()
            }
        }
    }
}

