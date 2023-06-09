//
//  HomeVM.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import Foundation
import Combine
import UIKit


class HomeVModel: ObservableObject {
    
    @Published var memes: [RedditChild]?
    @Published var afterPage: String = ""
    @Published var error: Error?
    @Published var loader: Bool = false
    var cancellables: Set<AnyCancellable> = []
    
    @Published var searchText: String = ""

    
 
    //MARK: Funcion para el complation de combine para peticion API Rest

    func networkGeneral(_ url: URL, _ after: String?){
        NetworkingManager.fetchData(from: url)
                    // Realizamos la peticion al API rest y generamos un completion para luego decodificar

                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] completion in
                        switch completion {
                        case .finished:
                            
                            break
                        case .failure(let error):
                            self?.loader = false
                            self?.error = error
                        }
                    } receiveValue: { [weak self] data in
                        // Decodificamos el Response que obtenemos del API
                        do {
                            let response = try JSONDecoderManager.decode(RedditResponse.self, from: data)
                            self?.afterPage = response.data.after
                            if let filteredMemes = self?.filterMemesAndImage(meme: response.data.children) {
                                if after != nil {
                                    filteredMemes.compactMap({ child in
                                        self?.memes?.append(child)
                                        
                                   })
                                    
                                    if (!(self?.searchText.isEmpty ?? false)) {
                                        self?.filterMemesBySearchText(meme: filteredMemes)
                                    }
                                    self?.loader = false
                                }else{
                                    self?.loader = false
                                    self?.memes = filteredMemes

                                }
                                
                            }
                        } catch {
                            self?.loader = false
                            self?.error = error
                        }
                    }
                    .store(in: &cancellables)
    }
    
    //MARK: Funcion para peticion rest API para paginacion o obtener memes

    func fetchCombineMemes(_ after: String?) {
        loader = true
        guard let url = URL(string: "https://www.reddit.com/r/chile/new/.json?limit=100&after=\(after ?? "")") else {
            error = APIError.invalidURL
            return
        }
        
        networkGeneral(url, after)
        
    }
    
    
    //MARK: Funcion para peticion rest API del search

    
    func fetchCombineMemes2(_ after: String?) {
        let searchQuery = searchText
        guard let url = URL(string: "https://www.reddit.com/r/chile/search.json?q=\(searchQuery)&limit=100") else {
            error = APIError.invalidURL
            return
        }
        
        networkGeneral(url, after)
        
    }
    
    //MARK: Funcion para filtrar elementos del search segun lo tipado en el SearchBar
    
    func filterMemesBySearchText(meme: [RedditChild]?) {
        if let meme = memes {
            if !meme.isEmpty {
                print("Vacios")
                self.memes = meme.filter { $0.data.title.lowercased().contains(searchText.lowercased()) }

            }

        }
        
    }
    
    
    //MARK: Funcion para filtrar elementos segun la categoria y si tienen imagen
    func filterMemesAndImage(meme: [RedditChild]) -> [RedditChild] {
        return meme.filter { $0.data.link_flair_text == "Shitposting" && $0.data.post_hint == "image" }
    }
    
    //MARK: Funcion para detectar el scroll del List y verificar si esta cerca del final para realizar paginacion
    func memeIsNearEnd(_ meme: RedditChild, in memes: [RedditChild]) -> Bool {
        // Obtener el índice del meme actual
        guard let currentIndex = memes.firstIndex(where: { $0.id == meme.id }) else { return false }
        
        // Calcular la posición relativa del meme actual en la lista
        let thresholdPercentage: Double = 0.98
        let visibleItemsCount = Double(currentIndex + 1)
        let totalItemsCount = Double(memes.count)
        let relativePosition = visibleItemsCount / totalItemsCount
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        // Comprobar si el meme está cerca del final de la lista
        return relativePosition >= thresholdPercentage
    }
    
}



