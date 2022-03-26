//
//  NetworkDemoTests.swift
//  NetworkDemoTests
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import XCTest
@testable import NetworkDemo

//class MovieListViewModelTests: XCTestCase {
//
//    @MainActor
//    func testFetchMovies() async throws {
//        let returnObject: [DataModel.Movie] = []
//        let mockNetworkService = MockNetworkService(returnObject: returnObject)
//        let viewModel = MovieListViewModel(coordinator: MockMoviesCoordinator(), networkService: <#T##NetworkServicing#>)
//        
//        await viewModel.load()
//        
//        XCTAssertEqual(viewModel.movies, [])
//    }
//
//}
//
//class MockMoviesCoordinator: MoviesCoordinating {
//    func openMovieDetailsScreen(movieId: Int) {}
//}
//
//
//extension DataModel.Movie: Equatable {
//    public static func == (lhs: DataModel.Movie, rhs: DataModel.Movie) -> Bool {
//        return lhs.id == rhs.id
//    }
//}
