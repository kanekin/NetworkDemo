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
    private let id: Int
    private let networkService: NetworkService
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
}


