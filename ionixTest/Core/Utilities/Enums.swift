//
//  Enums.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import Foundation

//MARK: Lo utiles que nos son los enums, aqui muestro varias formas de utilizarlos



//MARK: Navegacion
enum Page {
    case onboarding
    case login
    case registration
    case home
    case rating
}

//MARK: Control de estado

enum LaunchScreenStep {
    case firstStep
    case secondStep
    case finished
}

//MARK: Data estatica para maquetar y traducir

enum OnboardingStrings: String{
    case onboardingImage1 = "onboarding1"
    case onboardingImage2 = "onboarding2"
    case onboardingImage3 = "onboarding3"
    case onboardingTittle1 = "Camera Access"
    case onboardingTittle2 = "Enable push notificacions"
    case onboardingTittle3 = "Enable locations service"
    case onboardingCaption1 = "Please allow access to your camera to take photos."
    case onboardingCaption2 = "Enable push notifications to let send you personal news and updates."
    case onboardingCaption3 = "We want to access your location only to provide a better experience by helping you find new friends nearby."

    func getImageName() -> String {
        return self.rawValue
    }
}

//MARK: Manejo de errores

enum APIError: Error {
    case invalidURL
    case noDataReceived
    case invalidResponse
    case invalidMemeData
}
