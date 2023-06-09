//
//  Extensions.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import Foundation

//MARK: Es bueno idenficar con un ID unico los errores ocurridos en la app ya que puedes clasificalos y siempre van a servir como data para control y mejora de la app

struct IdentifiableError: Identifiable {
    let id = UUID()
    let localizedDescription: String
}

extension Error {
    var identifiableError: IdentifiableError {
        IdentifiableError(localizedDescription: localizedDescription)
    }
}
