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
    private weak var coordinator: MoviesCoordinating?
    let networkService: NetworkServicing
    @Published var movies: [DataModel.Movie] = []
    @Published var selectedMovieDetailsViewModel: MovieDetailsViewModel? = nil
   
    init(coordinator: MoviesCoordinating, networkService: NetworkServicing) {
        self.coordinator = coordinator
        self.networkService = networkService
    }
    
    func load() async {
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
    
    func selectMovie(id: Int) {
        coordinator?.openMovieDetailsScreen(movieId: id)
    }
}
