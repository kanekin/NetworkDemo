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
        let viewModel = MovieListViewModel(networkService: mockNetworkService)
        
        viewModel.load()
        
        XCTAssertNil(viewModel.movies)
    }

}
