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
            List(viewModel.movies) { movie in
                NavigationLink(
                    tag: movie.id,
                    selection: $selection,
                    destination: {
                        MovieDetailsScreen(viewModel: .init(id: movie.id, networkService: viewModel.networkService))
                    },
                    label: {
                        MovieListCell(movie: movie)
                            .padding(.init(top: 8.0, leading: 0.0, bottom: 8.0, trailing: 0.0))
                    })
            }
            .listStyle(.plain)
            .navigationTitle("Popular Films")
            .onAppear {
                viewModel.load()
            }
        }
    }
}

