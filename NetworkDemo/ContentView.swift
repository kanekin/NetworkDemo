//
//  ContentView.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import SwiftUI

enum HomeTab {
    case account
    case list
}

struct ContentView: View {
    var body: some View {
        TabView {
            
            AccountOptionsScreen()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
            
            MovieListScreen(
                viewModel: MovieListViewModel(
                    networkService: NetworkService(
                        session: URLSession.shared,
                        decoder: JSONDecoder())
                )
            )
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
                .tag(HomeTab.list)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
