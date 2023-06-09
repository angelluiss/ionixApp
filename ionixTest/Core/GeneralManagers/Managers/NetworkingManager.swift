//
//  NetworkingManager.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import Foundation
import Combine

//MARK: Aqui podemos manejar peticiones POST, GET, Entre otras
class NetworkingManager {
    static func fetchData(from url: URL) -> AnyPublisher<Data, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .eraseToAnyPublisher()
    }
    
}

