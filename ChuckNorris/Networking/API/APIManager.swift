//
//  APIManager.swift
//  ChuckNorris
//
//  Created by Byron Mejia on 9/19/22.
//

import Combine
import SwiftUI

protocol CategorieListStore {
    func readCategorieList() -> AnyPublisher<[String], Failure>
}

protocol ChuckJokeStore {
    func readChuckJoke(for categorieName: String) -> AnyPublisher<ChuckJoke, Failure>
}

final class APIManager {
    let baseURL = "https://api.chucknorris.io/jokes/"
}

extension APIManager: CategorieListStore {
    func readCategorieList() -> AnyPublisher<[String], Failure> {
        let path = "categories"
        guard let url = URL(string: self.baseURL + path) else {
            return Fail(error: Failure.urlConstructError).eraseToAnyPublisher()
        }
        
        let urlRequest = URLRequest(url: url)
        return URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { error in
                Failure.APIError(error)
            }
            .flatMap { data, response -> AnyPublisher<[String], Failure> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: Failure.unknown).eraseToAnyPublisher()
                }
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    return Just(data)
                        .decode(type: [String].self, decoder: jsonDecoder)
                        .mapError { _ in Failure.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: Failure.statusCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

extension APIManager: ChuckJokeStore {
    func readChuckJoke(for categorieName: String) -> AnyPublisher<ChuckJoke, Failure> {
        let path = "random?category=\(categorieName)"
        guard let url = URL(string: self.baseURL + path) else {
            return Fail(error: Failure.urlConstructError).eraseToAnyPublisher()
        }
        
        let urlRequest = URLRequest(url: url)
        return URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { error in
                Failure.APIError(error)
            }
            .flatMap { data, response -> AnyPublisher<ChuckJoke, Failure> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: Failure.unknown).eraseToAnyPublisher()
                }
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    return Just(data)
                        .decode(type: ChuckJoke.self, decoder: jsonDecoder)
                        .mapError { _ in Failure.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: Failure.statusCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
