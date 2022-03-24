//
//  MoviesCoordinator.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 24/03/2022.
//

import Combine

@MainActor
protocol MoviesCoordinating: AnyObject {
    func openMovieDetailsScreen(movieId: Int)
}

@MainActor
class MoviesCoordinator: MoviesCoordinating, ObservableObject {
    
    private let viewModelFactory: ViewModelFactory
    var movieListViewModel: MovieListViewModel!
    @Published var selectedMovieDetailsViewModel: MovieDetailsViewModel?
    
    init(viewModelFactory: ViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.movieListViewModel = viewModelFactory.makeMovieListViewModel(coordinator: self)
    }
    
    func openMovieDetailsScreen(movieId: Int) {
        selectedMovieDetailsViewModel = viewModelFactory.makeMovieDetailsViewModel(movieId: movieId)
    }
    
}
