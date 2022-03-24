//
//  ViewModelFactory.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 24/03/2022.
//

import Foundation

class ViewModelFactory {
    lazy var networkService: NetworkService = {
        return NetworkService()
    }()
    
    @MainActor
    func makeMovieListViewModel() -> MovieListViewModel {
        return MovieListViewModel(viewModelFactory: self, networkService: networkService)
    }
    
    @MainActor
    func makeMovieDetailsViewModel(movieId: Int) -> MovieDetailsViewModel {
        return MovieDetailsViewModel(id: movieId, networkService: networkService)
    }
    
    @MainActor
    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(networkService: networkService)
    }
}
