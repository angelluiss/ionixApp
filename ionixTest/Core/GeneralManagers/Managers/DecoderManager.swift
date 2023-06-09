//
//  DecoderManager.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import Foundation

//MARK: Un Simple Manager que puede llegar a ser muy robust si trabajas con procesos de decodificacion y codificacion avanzados
class JSONDecoderManager {
    static func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
}
