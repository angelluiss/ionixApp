//
//  MainOnboardingPageView.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import SwiftUI

struct MainOnboardingPageView: View {
    @State private var currentPageIndex = 0
    @State private var scale = 1.0
    @EnvironmentObject private var viewModel: NavigationViewModel
    @EnvironmentObject private var permisionManager: PermisionManager
    let onboarding = OnboardingStrings.self
    //MARK: Aqui hacemos uso de los user default de una manera novedosa y sencilla que nos ofrece swiftUI
    @AppStorage("isOnboardingCompleted") private var isOnboardingCompleted = false
    
    
    var body: some View {
        VStack{
            TabView(selection: $permisionManager.activeTabIndex) {
                //MARK: SubView de Permisos para camara

                OnboardingSV(imageName: onboarding.onboardingImage1.getImageName(), title: onboarding.onboardingTittle1.getImageName(), description: onboarding.onboardingCaption1.getImageName(), buttonTittle: "Allow",
                             actionButton: {
                    
                    permisionManager.requestCameraPermissions()
                },
                             actionCancel: {
                    permisionManager.changeTab(to: 1)
                })
                .tag(0)
                
                //MARK: SubView de Permisos para notificationes push
                OnboardingSV(imageName: onboarding.onboardingImage2.getImageName(), title: onboarding.onboardingTittle2.getImageName(), description: onboarding.onboardingCaption2.getImageName(),buttonTittle: "Enable",
                             actionButton: {
                    permisionManager.requestNotificationPermissions()
                },
                             actionCancel: {
                    permisionManager.changeTab(to: 2)
                })
                .tag(1)
                
                
                //MARK: SubView de Permisos para location

                OnboardingSV(imageName: onboarding.onboardingImage3.getImageName(), title: onboarding.onboardingTittle3.getImageName(), description: onboarding.onboardingCaption3.getImageName(),buttonTittle: "Enable",
                             actionButton: {
                    if permisionManager.areLocationPermissionsGranted() {
                        isOnboardingCompleted = true
                        permisionManager.changeTab(to: 0)
                        viewModel.navigateToHome()
                    }else {
                        permisionManager.requestLocationPermision()

                    }
                },
                             actionCancel: {
                    isOnboardingCompleted = true
                    viewModel.navigateToHome()
                })
                .tag(2)
            }
            .onAppear{
                //MARK: Aqui tenemos un Handler para manejar la navegacion del onboarding y no tener que visualizarlo cada vez que se inicie la app

                permisionManager.locationPermissionGrantedAction = {
                    isOnboardingCompleted = true
                    viewModel.navigateToHome()
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            
            
            
        }
    }
}

struct MainOnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainOnboardingPageView()
    }
}
