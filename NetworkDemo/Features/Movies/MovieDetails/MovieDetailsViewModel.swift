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
    @Published var credits: DataModel.Movie.Credits?
    
    init(id: Int, networkService: NetworkService) {
        self.id = id
        self.networkService = networkService
    }
    
    func load() async {
        do {
            async let movieDetails = try await networkService.load(resource: Resources.Movie.getDetails(id: id))
            async let credits = try await networkService.load(resource: Resources.Movie.getCredits(id: id))
            self.movieDetails = try await movieDetails
            self.credits = try await credits
        } catch {
            guard let appError = error as? AppError else {
                Logger.network.error("unknown error on network service")
                return
            }
            Logger.network.error("\(appError.localizedDescription)")
        }
    }
    
    func submitRating(_ rating: Int, for movieId: Int) async {
        do {
            let status = try await networkService.load(resource: Resources.Movie.postRating(.init(value: rating), for: movieId))
            Logger.network.log("submit rating response status: \(status.statusCode): \(status.statusMessage)")
        } catch {
            guard let appError = error as? AppError else {
                Logger.network.error("unknown error on network service")
                return
            }
            Logger.network.error("\(appError.localizedDescription)")
        }
    }
    
    deinit {
        print("deinitializing \(String(describing: self))")
    }
}


