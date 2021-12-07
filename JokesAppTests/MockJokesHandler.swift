//
//  MockJokesHandler.swift
//  JokesAppTests
//
//  Created by Jose Augusto Costa Martins Jr on 07/12/21.
//

import Foundation
@testable import JokesApp

class MockJokesHandler: JokesHandler {
    var didReceiveJokesCalled = false
    func didReceiveJokes() {
        didReceiveJokesCalled = true
    }

    var didReceiveErrorCalled = false
    func didReceiveError(error: String) {
        didReceiveErrorCalled = true
    }
}
