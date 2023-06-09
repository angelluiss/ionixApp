//
//  RootOnboardingView.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import SwiftUI

//MARK: Siguiendo un poco con los principios SOLID tratamos de mantener todo simple y separado, por aqui esta el root o navigation del Onboarding

struct RootOnboardingView: View {
    @State var splashScreen  = true
    
    var body: some View {
        ZStack{
            Group{
                if splashScreen {
                    SpinnerCustom()
                }
                else{
                    MainOnboardingPageView()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline:
                        .now() + 3) {
                                splashScreen = false
                                
                            }
            }
        }
    }

    
}

struct RootOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        RootOnboardingView()
    }
}
