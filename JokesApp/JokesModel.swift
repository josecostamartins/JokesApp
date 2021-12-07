//
//  JokesModel.swift
//  JokesApp
//
//  Created by Jose Augusto Costa Martins Jr on 07/12/21.
//

import Foundation

struct Joke: Codable {
    let id: String
    let joke: String
}

struct JokeResponse {
    let currentPage: Int
    let nextPage: Int
    let results: [Joke]
}

extension JokeResponse: Codable {

    public static func from(data: Data?) -> JokeResponse? {
        guard let data = data else { return nil }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response = try decoder.decode(JokeResponse.self, from: data)
            return response
        } catch let error {
                print(error)
        }

        return nil
    }
}
