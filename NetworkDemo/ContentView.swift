//
//  ContentView.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MovieListScreen(
            viewModel: MovieListViewModel(
                networkService: NetworkService(
                    session: URLSession.shared,
                    decoder: JSONDecoder())
            )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
