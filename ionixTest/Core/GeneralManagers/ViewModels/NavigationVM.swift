//
//  NavigationVM.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import Foundation

//MARK: Maneje el root de la App a traver de una aquitectura de MVVM. Hay algunas rutas adicionales solo de referencia


class NavigationViewModel: ObservableObject {
    @Published var currentPage: Page = .onboarding

    func navigateToLogin() {
        currentPage = .login
    }
    

    func navigateToRegistration() {
        currentPage = .registration
    }

    func navigateToHome() {
        currentPage = .home
    }
    
    func navigateToOnboarding() {
        currentPage = .onboarding
    }
    
    func navigateToRating() {
        currentPage = .rating
    }
}
