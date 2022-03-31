//
//  LoginViewModelTests.swift
//  NetworkDemoTests
//
//  Created by Tatsuya Kaneko on 25/03/2022.
//

import XCTest
@testable import NetworkDemo

class LoginViewModelTests: XCTestCase {

    func testLogin_Success() async {
        // Arrange:
        let mockLoginNetworkHandler = MockLoginNetworkHandler(
            onGetRequestToken: {
                return .init(success: true, expiresAt: nil, requestToken: "token")
            },
            onValidateToken: { token in
                return .init(success: true, expiresAt: nil, requestToken: token)
            },
            onCreateSession: {
                return .init(success: true, sessionId: "sessionId")
            }
        )
        
        let viewModel = LoginViewModel(loginNetworkHandler: mockLoginNetworkHandler, sessionStorage: MockSessionStorage())
        
        // Act:
        await viewModel.submitLogin(username: "username", password: "password")
        
        // Assert:
        XCTAssertNotNil(viewModel.sessionId)
    }

    func testLogin_failsOnCreatingSession() async {
        //Arrange
        let mockLoginNetworkHandler = MockLoginNetworkHandler(
            onGetRequestToken: {
                return .init(success: true, expiresAt: nil, requestToken: "token")
            },
            onValidateToken: { token in
                return .init(success: true, expiresAt: nil, requestToken: token)
            },
            onCreateSession: {
                return .init(success: false, sessionId: "sessionId")
            }
        )
        let viewModel = LoginViewModel(loginNetworkHandler: mockLoginNetworkHandler, sessionStorage: MockSessionStorage())
        
        // Act:
        await viewModel.submitLogin(username: "username", password: "password")
        
        // Assert:
        XCTAssertNil(viewModel.sessionId)
    }
    
    func testLogin_throwsOnCreatingSession_errorMessageIsPresent() async {
        // Arrange:
        let mockLoginNetworkHandler = MockLoginNetworkHandler(
            onGetRequestToken: {
                return .init(success: true, expiresAt: nil, requestToken: "token")
            },
            onValidateToken: { token in
                return .init(success: true, expiresAt: nil, requestToken: token)
            },
            onCreateSession: {
                throw AppError.network(type: .invalidResponse)
            }
        )
        
        let viewModel = LoginViewModel(loginNetworkHandler: mockLoginNetworkHandler, sessionStorage: MockSessionStorage())
        
        // Act:
        await viewModel.submitLogin(username: "username", password: "password")
        
        // Assert:
        XCTAssertNil(viewModel.sessionId)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}

class MockSessionStorage: SessionStoring {
    
    var sessionId: String?
    func setSession(id: String?) {
        sessionId = id
    }
}

struct MockLoginNetworkHandler: LoginNetworkHandling {
    
    let onGetRequestToken: () throws -> DataModel.Authentication.Token
    let onValidateToken: (String) throws -> DataModel.Authentication.Token
    let onCreateSession: () throws -> DataModel.Authentication.Session
    
    func getRequestToken() async throws -> DataModel.Authentication.Token {
        try onGetRequestToken()
    }
    
    func validateToken(username: String, password: String, token: String) async throws -> DataModel.Authentication.Token {
        try onValidateToken(token)
    }
    
    func createSession(token: String) async throws -> DataModel.Authentication.Session {
        try onCreateSession()
    }
}
