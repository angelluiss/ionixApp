//
//  LaunchScreenManager.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import Foundation

//MARK: Manager de pasos del splashScreen

final class LaunchScreenStateManager: ObservableObject {
    
    @MainActor @Published private(set) var state: LaunchScreenStep = .firstStep
    
    @MainActor func dismiss() {
        Task {
            state = .secondStep
            
            try? await Task.sleep(for: Duration.seconds(1))
            
            self.state = .finished
        }
    }
}
