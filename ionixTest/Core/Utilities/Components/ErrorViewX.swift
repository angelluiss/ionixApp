//
//  ErrorViewX.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 09/06/2023.
//

import SwiftUI

//MARK: View Generica para errores o notFound

struct ErrorViewX: View {
    let imageName: String
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Text(title)
                .font(.title2)
                .fontWeight(.regular)
                .frame(width: 246)
                .padding()
            
            Text(description)
                .font(.body)
                .fontWeight(.light)
                .frame(width: 246)
                .multilineTextAlignment(.center)
                .padding()
                        
        
            
        }
        .padding()
    }
}

struct ErrorViewX_Previews: PreviewProvider {
    static var previews: some View {
        ErrorViewX(imageName: "upset", title: "Sorry, we have troubles!", description: "Error")
    }
}
