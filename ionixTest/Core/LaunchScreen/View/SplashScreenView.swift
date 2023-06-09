//
//  SplashScreenView.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import SwiftUI

//MARK: Por siempre estar animado cae de lo mejor, tenemos un LaunchScreen o SplashScreen muy bien animado

struct SplashScreenView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    @State private var animateOffset = false
    //MARK: SplashScreen animado con swiftUI
    private let animationTimer = Timer // Mark 5
        .publish(every: 0.5, on: .current, in: .common)
        .autoconnect()
    
    //MARK: Si lo tuyo es renovar, aqui puedes cambiar tu logo principal del Splash Screen

    @ViewBuilder
    private var image: some View {  // Mark 3
        
        Image("reddit-logo1")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .offset(x: 0, y: 0)
            .frame(width: 200, height: 200)
            .offset(x: 0, y: animateOffset ? 0 : -800)
        

    }
    
    //MARK: Aqui puedes personalizar y agregar el background image de tu preferencia
    
    @ViewBuilder
    private var backgroundImage: some View {  // Mark 3
        Image("background")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    
    
    var body: some View {
        ZStack {
            
            backgroundImage
            
            image
            
        }
        .animation(.easeOut(duration: 2), value: animateOffset)
        .onAppear(perform: {
            animateOffset = true
        })
        .onReceive(animationTimer) { timerValue in
            updateAnimation()  // Mark 5
        }
      
    }
    
    //MARK: Una funcion privada donde puedes realizar otra actiones como relizar una peticion para actualizar datos location mientras carga tu splash Screen
    
    
    private func updateAnimation() { // Mark 5
        switch launchScreenState.state {
        case .firstStep:
           break
        case .secondStep: break
          
        case .finished:
            // use this case to finish any work needed
            break
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
            .environmentObject(LaunchScreenStateManager())
    }
}
