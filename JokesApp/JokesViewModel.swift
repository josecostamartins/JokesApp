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
    var handler: JokesHandler? { get set }
}

protocol JokesHandler: AnyObject {
    func didReceiveJokes()
    func didReceiveError(error: String)
}

final class DadJokesViewModel: JokesViewModel {
    private let jokesService: JokeService
    private(set) var jokesList: [Joke]
    private var currentPage: Int
    weak var handler: JokesHandler?

    init(jokesService: JokeService = DadJokeService()) {
        self.jokesService = jokesService
        self.jokesList = []
        self.currentPage = 1
    }

    func viewDidLoad() {
        jokesService.getAllJokes(page: currentPage) { [weak self] result in
            switch result {
                case .success(let jokesResult):
                    self?.jokesList = jokesResult.results
                    self?.currentPage = jokesResult.nextPage
                    self?.handler?.didReceiveJokes()
                case .failure(let error):
                    self?.handler?.didReceiveError(error: error.description)
            }
        }
    }
}
