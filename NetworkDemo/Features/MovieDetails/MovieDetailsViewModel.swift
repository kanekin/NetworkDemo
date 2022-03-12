//
//  MovieDetailsViewModel.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 12/03/2022.
//

import Foundation
import Combine
import os.log

@MainActor
class MovieDetailsViewModel: ObservableObject {
    let id: Int
    let networkService: NetworkService
    @Published var movieDetails: DataModel.Movie.Details?
    
    init(id: Int, networkService: NetworkService) {
        self.id = id
        self.networkService = networkService
    }
    
    func load() {
        Task {
            do {
                let movieDetails = try await networkService.load(resource: Resources.Movie.getDetails(id: id))
                print(movieDetails)
                self.movieDetails = movieDetails
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
