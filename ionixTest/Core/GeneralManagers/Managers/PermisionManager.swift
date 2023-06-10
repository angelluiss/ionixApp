//
//  PermisionManager.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import Foundation
import CoreLocation
import AVFoundation
import UserNotifications
import SwiftUI



class PermisionManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocation?
    @Published var activeTabIndex = 0
    @Published var allowAllPermisions = false
    var locationPermissionGrantedAction: (() -> Void)?
    
    override init() {
        super.init()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
    }
    
    //MARK: Location permisionManager
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            // El usuario ha aceptado los permisos de ubicación cuando la aplicación está en uso
            // Realiza las acciones necesarias aquí
            locationPermissionGrantedAction?()
            print("Permisos de ubicación aceptados (Cuando se usa la app)")
        case .authorizedAlways:
            // El usuario ha aceptado los permisos de ubicación siempre (incluso en segundo plano)
            // Realiza las acciones necesarias aquí
            print("Permisos de ubicación aceptados (Siempre)")
        default:
            // Los permisos de ubicación no están concedidos o el usuario los ha denegado
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error al obtener la ubicación: \(error.localizedDescription)")
    }
    
    //MARK: Request Location permisionManager
    func requestLocationPermision() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
       
    }
    
    
    //MARK: Ask for Location permisionManager

    func areLocationPermissionsGranted() -> Bool {
        let status =  CLLocationManager().authorizationStatus
        return status == .authorizedWhenInUse || status == .authorizedAlways
    }
    
    
    //MARK: Request permission camera

    func requestCameraPermissions()  {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            
            DispatchQueue.main.async {
                
                self.changeTab(to: 1)
                
                
            }
            print("Permision Granted \(granted)")
        }
    }
    
    
    //MARK: Request permission Notifications

    func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                // Permiso de notificación concedido
                DispatchQueue.main.async {
                    
                    self.changeTab(to: 2)
                    
                    
                }
            } else {
                // Permiso de notificación denegado
                DispatchQueue.main.async {
                    
                    self.changeTab(to: 2)
                    
                    
                }
            }
        }
    }
    
    
    //MARK: Cambiar de posicion el Tab

    func changeTab(to index: Int) {
        withAnimation {
            activeTabIndex = index
        }
        
    }
    
    
}
