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
    let loader: MovieListLoading
    @Published var movies: [DataModel.Movie] = []
    @Published var selectedMovieDetailsViewModel: MovieDetailsViewModel? = nil
   
    init(coordinator: MoviesCoordinating, loader: MovieListLoading) {
        self.coordinator = coordinator
        self.loader = loader
    }
    
    func load() async {
        do {
            self.movies = try await loader.load().results
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

protocol MovieListLoading {
    func load() async throws -> DataModel.Movies
}

class MovieListLoader: MovieListLoading {
    let networkService: NetworkServicing
    
    init(networkService: NetworkServicing) {
        self.networkService = networkService
    }
    
    func load() async throws -> DataModel.Movies {
        return try await networkService.load(resource: Resources.Movie.getPopular())
    }
}
