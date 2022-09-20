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
    @Published private(set) var state: CategorieStates = .loading
    
    init(store: CategorieListStore = APIManager()) {
        self.store = store
    }
    
    func getcategories() {
        let cancellable  = store.readCategorieList()
            .sink { result in
                switch result {
                    case .finished:
                        self.state = .success(content: self.categories)
                    case .failure(let error):
                        self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.categories = response
            }
        self.cancellables.insert(cancellable)
    }
}
