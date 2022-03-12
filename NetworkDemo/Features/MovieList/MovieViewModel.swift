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
    let networkService: NetworkService
    @Published var movies: [DataModel.Movie] = []
   
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func load() {
        Task {
            do {
                let movies = try await networkService.load(resource: Resources.Movies.getPopular())
                // TODO: add page support
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
}
