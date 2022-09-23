//
//  States.swift
//  ChuckNorris
//
//  Created by Byron Mejia on 9/20/22.
//

import Foundation

enum States {
    case loading
    case success(content: Any)
    case failed(error: Error)
}
