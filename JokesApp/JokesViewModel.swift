//
//  JokesViewModel.swift
//  JokesApp
//
//  Created by Jose Augusto Costa Martins Jr on 07/12/21.
//

import Foundation

protocol JokesViewModel {
    func viewDidLoad()
    var jokesList: [Joke] { get }
}

protocol JokesHandler: AnyObject {
    func didReceiveJokes()
}

final class DadJokesViewModel: JokesViewModel {
    private let jokesService: JokeService
    private(set) var jokesList: [Joke]
    private var currentPage: Int
    private weak var handler: JokesHandler?

    init(jokesService: JokeService = MockJokeService()) {
        self.jokesService = jokesService
        self.jokesList = []
        self.currentPage = 1
    }

    func viewDidLoad() {
        let jokesResult = jokesService.getAllJokes(page: currentPage)
        jokesList = jokesResult.results
        currentPage = jokesResult.nextPage
        handler?.didReceiveJokes()
    }
}
