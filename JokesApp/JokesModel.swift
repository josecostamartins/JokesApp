//
//  JokesModel.swift
//  JokesApp
//
//  Created by Jose Augusto Costa Martins Jr on 07/12/21.
//

import Foundation

struct JokeResponse: Codable {
    let currentPage: Int
    let nextPage: Int
    let results: [Joke]
}

struct Joke: Codable {
    let id: String
    let joke: String
}
