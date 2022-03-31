//
//  NetworkDemoTests.swift
//  NetworkDemoTests
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import XCTest
@testable import NetworkDemo

class MovieListViewModelTests: XCTestCase {

    @MainActor
    func testFetchMovies() async throws {
        let mockedMovies: DataModel.Movies = .init(
            page: 0,
            results: [
                .init(
                    id: 1,
                    title: "Test Movie 1",
                    releaseDate: "Release date",
                    originalLanguage: "English",
                    voteAverage: 7.8,
                    posterPath: "poster_path"
                )
            ])
        let mockLoader = MockMovieListLoader(movies: mockedMovies)
        let viewModel = MovieListViewModel(
            coordinator: MockMoviesCoordinator(),
            loader: mockLoader
        )
        
        await viewModel.load()
        
        XCTAssertEqual(viewModel.movies, mockedMovies.results)
    }

}

class MockMoviesCoordinator: MoviesCoordinating {
    func openMovieDetailsScreen(movieId: Int) {}
}

class MockMovieListLoader: MovieListLoading {
    private let movies: DataModel.Movies
    
    init(movies: DataModel.Movies) {
        self.movies = movies
    }
    
    func load() async throws -> DataModel.Movies {
        return movies
    }
}

extension DataModel.Movie: Equatable {
    public static func == (lhs: DataModel.Movie, rhs: DataModel.Movie) -> Bool {
        return lhs.id == rhs.id
    }
}
