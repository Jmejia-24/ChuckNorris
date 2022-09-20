//
//  Failure.swift
//  ChuckNorris
//
//  Created by Byron Mejia on 9/19/22.
//

import Foundation

enum Failure: Error {
    case decodingError
    case urlConstructError
    case APIError(Error)
    case statusCode(Int)
    case unknown
}
