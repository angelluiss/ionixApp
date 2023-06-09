//
//  ionixTestApp.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import SwiftUI

@main
struct ionixTestApp: App {
    
    

    @StateObject var launchScreenState = LaunchScreenStateManager()

    var body: some Scene {
        WindowGroup {
            ZStack{
                RootView()
                
                if launchScreenState.state != .finished {
                    SplashScreenView()
                }
            }.environmentObject(launchScreenState)
           
        }
    }
}
