//
//  JokesAppTests.swift
//  JokesAppTests
//
//  Created by Jose Augusto Costa Martins Jr on 07/12/21.
//

import XCTest
@testable import JokesApp

class JokesViewModelTests: XCTestCase {

    func test_DadJokesViewModel_callDidReceiveError() {
        var sut: JokesViewModel = DadJokesViewModel(jokesService: ErrorMockJokeService())
        let mockHandler = MockJokesHandler()
        sut.handler = mockHandler
        sut.viewDidLoad()
        XCTAssertTrue(mockHandler.didReceiveErrorCalled)
    }

    func test_DadJokesViewModel_callDidReceiveJokes() {
        var sut: JokesViewModel = DadJokesViewModel(jokesService: SuccessMockJokeService())
        let mockHandler = MockJokesHandler()
        sut.handler = mockHandler
        sut.viewDidLoad()
        XCTAssertTrue(mockHandler.didReceiveJokesCalled)
    }

}
