//
//  ContentView.swift
//  ChuckNorris
//
//  Created by Byron Mejia on 9/19/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CategorieListViewModel()
    
    var body: some View {
        Group {
            switch viewModel.state {
                case .loading:
                    ProgressView()
                case .failed(let error):
                    ErrorView(error: error, handler: viewModel.getcategories)
                case .success(let categories):
                    NavigationView {
                        List(categories, id: \.self) { item in
                            Text(item.capitalized)
                        }
                        .navigationTitle(Text("Categories"))
                    }
                    .navigationViewStyle(.stack)
            }
        }.onAppear(perform: viewModel.getcategories)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
