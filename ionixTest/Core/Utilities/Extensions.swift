//
//  Extensions.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import Foundation

//MARK: Es bueno idenficar con un ID unico los errores ocurridos en la app ya que puedes clasificarlos y siempre van a servir como data para control y mejora de la app


/* El código muestra una implementación para asignar un ID único a los errores y facilitar su identificación y clasificación. No se refiere a un patrón de diseño específico, sino más bien a una técnica para mejorar el control y la gestión de errores en la aplicación. */

struct IdentifiableError: Identifiable {
    let id = UUID()
    let localizedDescription: String
}

extension Error {
    var identifiableError: IdentifiableError {
        IdentifiableError(localizedDescription: localizedDescription)
    }
}
