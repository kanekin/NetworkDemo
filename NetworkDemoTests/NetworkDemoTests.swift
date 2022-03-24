//
//  NetworkDemoTests.swift
//  NetworkDemoTests
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import XCTest
@testable import NetworkDemo

class NetworkDemoTests: XCTestCase {

    @MainActor
    func testNetwork() throws {
        let returnObject: [DataModel.Movie] = []
        let mockNetworkService = MockNetworkService(returnObject: returnObject)
        let viewModel = MovieListViewModel(coordinator: MockMoviesCoordinator(), networkService: <#T##NetworkServicing#>)
        
        viewModel.load()
        
        XCTAssertNil(viewModel.movies)
    }

}

class MockMoviesCoordinator: MoviesCoordinating {
    func openMovieDetailsScreen(movieId: Int) {}
}

class MockNetworkService: NetworkServicing {
    func load<T>(resource: Resource<T>) async throws -> T where T : Decodable {
        
    }
}
