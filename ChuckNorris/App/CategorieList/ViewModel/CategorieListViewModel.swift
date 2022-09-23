//
//  CategorieListViewModel.swift
//  ChuckNorris
//
//  Created by Byron Mejia on 9/19/22.
//

import SwiftUI
import Combine

class CategorieListViewModel: ObservableObject {
    
    private let store: CategorieListStore
    private(set) var categories = [String]()
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var state: States = .loading
    
    init(store: CategorieListStore = APIManager()) {
        self.store = store
    }
    
    func getCategories() {
        let cancellable  = store.readCategorieList()
            .sink { [unowned self] result in
                switch result {
                    case .finished:
                        state = .success(content: categories)
                    case .failure(let error):
                        state = .failed(error: error)
                }
            } receiveValue: { [unowned self] response in
                categories = response
            }
        self.cancellables.insert(cancellable)
    }
}

final class CategorieListCoordinator {
    public static func start() -> ContentView {
        let contentView = ContentView()
        return contentView
    }
}

final class ChuckJokeCoordinator {
    public static func start(with categorie: String) -> ChuckJokeView {
        let chuckJokeView = ChuckJokeView(viewModel: ChuckJokeViewModel(categorie: categorie))
        return chuckJokeView
    }
}
