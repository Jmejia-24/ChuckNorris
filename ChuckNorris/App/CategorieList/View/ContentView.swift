//
//  ContentView.swift
//  ChuckNorris
//
//  Created by Byron Mejia on 9/19/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CategorieListViewModel()
    
    var body: some View {
        Group {
            switch viewModel.state {
                case .loading:
                    ProgressView()
                case .failed(let error):
                    ErrorView(error: error, handler: viewModel.getCategories)
                case .success:
                    NavigationView {
                        List(viewModel.categories, id: \.self) { categorie in
                            NavigationLink(destination: ChuckJokeCoordinator.start(with: categorie)) {
                                Text(categorie.capitalized)
                            }
                        }
                        .navigationTitle(Text("Categories"))
                    }
                    .navigationViewStyle(.stack)
            }
        }.onAppear(perform: viewModel.getCategories)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
