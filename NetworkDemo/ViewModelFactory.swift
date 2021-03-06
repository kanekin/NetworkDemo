//
//  ViewModelFactory.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 24/03/2022.
//

import Foundation

class ViewModelFactory {
    private lazy var networkService: NetworkService = {
        return NetworkService()
    }()
    
    private lazy var sessionStorage: SessionStorage = {
        return SessionStorage()
    }()
    
    @MainActor
    func makeMovieListViewModel(coordinator: MoviesCoordinating) -> MovieListViewModel {
        return MovieListViewModel(coordinator: coordinator, loader: MovieListLoader(networkService: networkService))
    }
    
    @MainActor
    func makeMovieDetailsViewModel(movieId: Int) -> MovieDetailsViewModel {
        return MovieDetailsViewModel(id: movieId, networkService: networkService)
    }
    
    @MainActor
    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(
            loginNetworkHandler: LoginNetworkHandler(networkService: networkService),
            sessionStorage: SessionStorage()
        )
    }
}
