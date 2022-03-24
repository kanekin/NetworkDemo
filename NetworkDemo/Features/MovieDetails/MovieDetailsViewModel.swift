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
        print("initializing MovieDetailsViewModel")
        self.id = id
        self.networkService = networkService
    }
    
    func load() async {
        await getMovieDetails(id: id)
        await getMovieCredits(id: id)
    }
    
    private func getMovieDetails(id: Int) async {
        do {
            let movieDetails = try await networkService.load(resource: Resources.Movie.getDetails(id: id))
            self.movieDetails = movieDetails
        } catch {
            guard let appError = error as? AppError else {
                Logger.network.error("unknown error on network service")
                return
            }
            Logger.network.error("\(appError.localizedDescription)")
        }
    }
    
    private func getMovieCredits(id: Int) async {
        do {
            let credits = try await networkService.load(resource: Resources.Movie.getCredits(id: id))
            self.credits = credits
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


