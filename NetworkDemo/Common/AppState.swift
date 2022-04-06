//
//  AppState.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 06/04/2022.
//

import Combine

@MainActor
class AppState: ObservableObject {
    @Published var isLoggedIn: Bool
    
    init(isLoggedIn: Bool) {
        self.isLoggedIn = isLoggedIn
    }
}
