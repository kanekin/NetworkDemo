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
    
    private let viewModelFactory = ViewModelFactory()
    
    var body: some View {
        TabView {
            AccountOptionsScreen(viewModelFactory: viewModelFactory)
                .tabItem {
                    Label("Account", systemImage: "person")
                }
            
            MoviesCoordinatorView(coordinator: MoviesCoordinator(viewModelFactory: viewModelFactory))
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
                .tag(HomeTab.list)
        }
        .environmentObject(AppState(isLoggedIn: SessionStorage().sessionId != nil))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
