//
//  DadJokesService.swift
//  JokesApp
//
//  Created by Jose Augusto Costa Martins Jr on 07/12/21.
//

import Foundation

protocol JokeService {
    func getAllJokes(page: Int, completion: @escaping (Result<JokeResponse, Error>) -> Void)
}

final class MockJokeService: JokeService {

    func getAllJokes(page: Int, completion: @escaping (Result<JokeResponse, Error>) -> Void) {
        let response: Data = """
            {
              "current_page": 1,
              "limit": 20,
              "next_page": 2,
              "previous_page": 1,
              "results": [
                {
                  "id": "M7wPC5wPKBd",
                  "joke": "Did you hear the one about the guy with the broken hearing aid? Neither did he."
                },
                {
                  "id": "MRZ0LJtHQCd",
                  "joke": "What do you call a fly without wings? A walk."
                },
                {
                  "id": "usrcaMuszd",
                  "joke": "What's the worst thing about ancient history class? The teachers tend to Babylon."
                }
              ],
              "search_term": "",
              "status": 200,
              "total_jokes": 307,
              "total_pages": 15
            }
        """.data(using: .utf8)!
        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let jokes = try jsonDecoder.decode(JokeResponse.self, from: response)
            completion(.success(jokes))
        } catch let error {
            completion(.failure(error))
        }
    }
}
