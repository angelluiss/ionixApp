//
//  SearchBar.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 09/06/2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass") // Icono de búsqueda
                .foregroundColor(.gray)
            
            TextField("Buscar", text: $text)
                .foregroundColor(.gray)
                .padding(6)
                .onTapGesture {
                    // Si se toca el TextField, se asegura de que el teclado no se oculte
                    UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                }

            
            Button(action: {
                text = "" // Acción para borrar el texto de búsqueda
            }) {
                Image(systemName: "xmark.circle") // Icono para borrar el texto
                    .foregroundColor(.gray)
            }
            .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
        }
        .padding(6)
        .background(RoundedRectangle(cornerRadius: 30).stroke(Color.gray, lineWidth: 1)) // Estilo del fondo
        .padding(.horizontal)
    }
}



struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
