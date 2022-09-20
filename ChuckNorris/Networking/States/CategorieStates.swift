//
//  CategorieStates.swift
//  ChuckNorris
//
//  Created by Byron Mejia on 9/20/22.
//

import Foundation

enum CategorieStates {
    case loading
    case success(content: [String])
    case failed(error: Error)
}
