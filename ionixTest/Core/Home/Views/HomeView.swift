//
//  HomeView.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navVM: NavigationViewModel
    @StateObject var homeVM = HomeVModel()
    @State private var currentPage = 1
    @State private var isScrollAtEnd = false
    @State private var searchText = ""
    
    var body: some View {
        VStack{
            HStack {
                Button {
                    navVM.navigateToOnboarding()
                } label: {
                    Image("setting")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }
                .padding()
                
                Spacer()
            }
           
            
            SearchBar(text: $homeVM.searchText)
                
                .onChange(of: homeVM.searchText) { searchText in
                    print(searchText)
                    if (searchText == "") {
                        homeVM.fetchCombineMemes(nil)
                    }else{
                        homeVM.fetchCombineMemes2(homeVM.afterPage)
                    }
                   
                }
                
                
               

            if let meme = homeVM.memes {
                //MARK: View de Loading
                if (meme.isEmpty && homeVM.loader) {
                  
                        SpinnerCustom()
                            .padding()
                 
                    Spacer()
                }
                //MARK: View de not Found
                
                else if (meme.isEmpty && !homeVM.searchText.isEmpty) {
                    ErrorViewX(imageName: "search", title: "No Results", description: "Sorry, there are no result for this search. Please try another phrase")
                        .refreshable {
                            DispatchQueue.main.asyncAfter(deadline:
                                    .now() + 1.3) {
                                        homeVM.fetchCombineMemes(nil)
                                       
                                    }
                        }
                    
                    
                }
                //MARK: View de Lista
                else {
                    List(meme, id: \.id) { memer in
                        
                        CardView(meme: memer)
                            
                            .listStyle(.plain)
                            .onAppear {
                                // Detectar cuando el meme está cerca del final de la lista
                                if homeVM.memeIsNearEnd(memer, in: meme) {
                                    // Realizar la acción deseada (por ejemplo, cargar más memes)
                                    homeVM.fetchCombineMemes(homeVM.afterPage)
                                    print("Final del scroll")
                              
                                }
                            }
                           
                    }
                    
                    .listStyle(.plain)
                    .onTapGesture {
                        // Si se toca fuera del TextField, se oculta el teclado
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    
                    //MARK: Pull Down Refresh
                    .refreshable {
                        DispatchQueue.main.asyncAfter(deadline:
                                .now() + 1.3) {
                                    homeVM.fetchCombineMemes(nil)
                                   
                                }
                    }
                }
                
                
                
            }
            //MARK: View de Errores
            else if let error = homeVM.error {
                
                ErrorViewX(imageName: "upset", title: "Sorry, we have troubles!", description: "Error: \(error.localizedDescription)")
                    .refreshable {
                        DispatchQueue.main.asyncAfter(deadline:
                                .now() + 1.3) {
                                    homeVM.fetchCombineMemes(nil)
                                   
                                }
                    }
                    .foregroundColor(.red)
                .padding()
                
            }else{
                SpinnerCustom()
                    .padding()
                
                Spacer()
            }
        }
        .onAppear {
            homeVM.fetchCombineMemes(nil)
        }
        
    }
    
   
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}




