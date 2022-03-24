//
//  MovieViewModel.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import Foundation
import Combine
import os.log

@MainActor
class MovieListViewModel: ObservableObject {
    let viewModelFactory: ViewModelFactory
    let networkService: NetworkServicing
    @Published var movies: [DataModel.Movie] = []
    @Published var selectedMovieDetailsViewModel: MovieDetailsViewModel? = nil
   
    init(viewModelFactory: ViewModelFactory, networkService: NetworkServicing) {
        self.viewModelFactory = viewModelFactory
        self.networkService = networkService
    }
    
    func load() {
        Task {
            do {
                let movies = try await networkService.load(resource: Resources.Movie.getPopular())
                self.movies = movies.results
            } catch {
                guard let appError = error as? AppError else {
                    Logger.network.error("unknown error on network service")
                    return
                }
                Logger.network.error("\(appError.localizedDescription)")
            }
        }
    }
    
    func selectMovie(id: Int) {
        selectedMovieDetailsViewModel = viewModelFactory.makeMovieDetailsViewModel(movieId: id)
    }
}
