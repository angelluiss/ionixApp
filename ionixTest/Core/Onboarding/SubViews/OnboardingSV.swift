//
//  OnboardingSV.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import SwiftUI

//MARK: Aca tenemos el SubView del Onboarding donde se realizan las peticiones, es una View Generico ya que puedes reutilizarzo en muchos lugares de la app


struct OnboardingSV: View {
    
    let imageName: String
    let title: String
    let description: String
    let buttonTittle: String
    var actionButton: () -> Void
    var actionCancel: () -> Void
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Text(title)
                .font(.title2)
                .fontWeight(.regular)
                .frame(width: 246)
                .padding()
            
            Text(description)
                .font(.body)
                .fontWeight(.light)
                .frame(width: 246)
                .multilineTextAlignment(.center)
                .padding()
                        
            //MARK: Action Button
            Button (action: actionButton) {
                Text(buttonTittle)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 185 ,height: 50)
                    .background(  LinearGradient(
                        gradient: Gradient(colors: [Color("ColorGradient1"), Color("ColorGradient2")]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .cornerRadius(30)
            }
            
            //MARK: Cancel Button
            Button (action: actionCancel) {
                Text("Cancel")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .frame(width: 185 ,height: 50)
                    .padding(.vertical)
            }
            .padding(.horizontal)
            
        }
        .padding()
    }
}

struct OnboardingSV_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSV(imageName: OnboardingStrings.onboardingImage1.getImageName(), title: OnboardingStrings.onboardingTittle1.getImageName(), description: "Please allow access to your camera to take photos", buttonTittle: "Action", actionButton: {}, actionCancel: {})
    }
}
