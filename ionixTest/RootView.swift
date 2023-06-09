//
//  RootView.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import Foundation
import SwiftUI

struct RootView: View {
    //MARK: Compartimos el NavigationViewModel y PermisionManager para poder utilizarlo de forma sencilla en toda la app y no tener que inicializarlo cada que llamemos a una clase o un Struct nuevo, ahorremos memoria
    
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager

    @StateObject private var viewModel = NavigationViewModel()
    @StateObject private var permisionVM = PermisionManager()
    @AppStorage("isOnboardingCompleted") private var isOnboardingCompleted = false

    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.currentPage {
                case .onboarding:
                    RootOnboardingView()
                case .login:
                    EmptyView()
                case .registration:
                    EmptyView()
                case .home:
                    HomeView()
                case .rating:
                    EmptyView()
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .environmentObject(viewModel)
            .environmentObject(permisionVM)
            .animation(Animation.easeIn, value: 1.0)
            .transition(.slide)
        }
        .task {
            try? await checkPermisions()
            try? await Task.sleep(for: Duration.seconds(1))
            self.launchScreenState.dismiss()
        }
      
        
        
    }
    
    //MARK: Aqui verificamos si los permisos han sido aceptados o no y navegamos a la pantalla segune el caso
 
    func checkPermisions() async throws {
        
        if isOnboardingCompleted  {
            // El usuario ya está autenticado, navegar a la vista de inicio
            viewModel.currentPage = .home
        } else {
            // El usuario no está autenticado, mostrar la vista de inicio de sesión
            if viewModel.currentPage != .onboarding {
                viewModel.currentPage = .login
            }else{
                viewModel.currentPage = .onboarding
            }
        }
    }
       
}



struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(LaunchScreenStateManager())
    }
}
