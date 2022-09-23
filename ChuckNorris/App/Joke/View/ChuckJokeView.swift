//
//  ChuckJokeView.swift
//  ChuckNorris
//
//  Created by Byron Mejia on 9/20/22.
//

import SwiftUI

struct ChuckJokeView: View {
    @ObservedObject var viewModel: ChuckJokeViewModel
    
    var body: some View {
        VStack {
            Button {
                viewModel.getChuckJoke()
            } label: {
                Label("Refresh", systemImage: "arrow.triangle.2.circlepath")
                    .font(.title2)
            }
            .buttonStyle(.bordered)
            .foregroundColor(.green)
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(lineWidth: 2.0)
                    .foregroundColor(.green)
            )
            .padding()
            
            switch viewModel.state {
                case .loading:
                    ProgressView()
                case .failed(let error):
                    ErrorView(error: error, handler: viewModel.getChuckJoke)
                case .success:
                    Text(viewModel.chuckJoke?.value ?? "")
                        .font(.title2)
                        .padding()
            }
        }
        .navigationTitle(viewModel.categorie?.capitalized ?? "Joke")
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .onAppear(perform: viewModel.getChuckJoke)
    }
}
