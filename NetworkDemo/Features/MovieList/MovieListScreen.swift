//
//  MovieListView.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import SwiftUI

struct MovieListScreen: View {
    @ObservedObject var viewModel: MovieListViewModel
    
    var body: some View {
        List(viewModel.movies) { movie in
            MovieListCell(movie: movie)
                .padding(.init(top: 8.0, leading: 0.0, bottom: 8.0, trailing: 0.0))
        }
        .listStyle(.plain)
        .onAppear {
            viewModel.load()
        }
    }
}
