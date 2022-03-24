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
        List(viewModel.movies) { movie in
            Button(action: {
                viewModel.selectMovie(id: movie.id)
            }, label: {
                MovieListCell(movie: movie)
            })
        }
        .listStyle(.plain)
        .navigationTitle("Popular Films")
        .onAppear {
            viewModel.load()
        }
    }
}

