//
//  ErrorView.swift
//  ChuckNorris
//
//  Created by Byron Mejia on 9/20/22.
//

import SwiftUI

struct ErrorView: View {
    typealias ErrorViewActionHandler = () -> Void
    let error: Error
    let handler: ErrorViewActionHandler
    
    internal init(error: Error, handler: @escaping ErrorViewActionHandler) {
        self.error = error
        self.handler = handler
    }
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.icloud.fill")
                .foregroundColor(.gray)
                .font(.system(size: 50,weight: .heavy))
                .padding(.bottom, 4)
            
            Text("Ooppps")
                .foregroundColor(.black)
                .font(.system(size: 30,weight: .heavy))
                .multilineTextAlignment(.center)
            
            Text(error.localizedDescription)
                .foregroundColor(.gray)
                .font(.system(size: 10))
                .multilineTextAlignment(.center)
            
            Button{
                self.handler()
            } label: {
                Text("Retry")
            }
            .padding(10)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: Failure.decodingError, handler: {})
            .previewLayout(.sizeThatFits)
    }
}
