//
//  ChuckJokeViewModel.swift
//  ChuckNorris
//
//  Created by Byron Mejia on 9/20/22.
//

import Foundation

import SwiftUI
import Combine

class ChuckJokeViewModel: ObservableObject {
    
    @Published private(set) var state: States = .loading
    private let store: ChuckJokeStore
    private(set) var chuckJoke: ChuckJoke?
    private var cancellables = Set<AnyCancellable>()
    let categorie: String?
    
    
    init(categorie: String, store: ChuckJokeStore = APIManager()) {
        self.store = store
        self.categorie = categorie
    }
    
    func getChuckJoke() {
        state = .loading
        let cancellable  = store.readChuckJoke(for: categorie ?? "")
            .sink { [unowned self] result in
                switch result {
                    case .finished:
                        guard let chuckJoke = chuckJoke else { return }
                        state = .success(content: chuckJoke)
                    case .failure(let error):
                        state = .failed(error: error)
                }
            } receiveValue: { [unowned self] response in
                chuckJoke = response
            }
        self.cancellables.insert(cancellable)
    }
}
