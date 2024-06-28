//
//  PTLocationManager.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 29/06/24.
//

import Foundation
import CoreLocation

class PTLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    private var locationStatus: CLAuthorizationStatus?
    private var lastLocation: CLLocation?
    @Published var cityName: String?
    
    private var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        if status == .notDetermined || status == .denied {
            let storedLocation = UserDefaults.standard.retrieve(object: PTLocation.self, fromKey: PTConstantKey.location)
            self.cityName = storedLocation?.city
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        print(#function, location)
        getCityAndCountryLocation(latitude: lastLocation?.coordinate.latitude ?? 0.0, longitude: lastLocation?.coordinate.longitude ?? 0.0)
    }
    
    private func getCityAndCountryLocation(latitude: Double, longitude: Double) {

        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude), preferredLocale: Locale.current) { placemarks, _ in
             guard let placeMark = placemarks?.first else {
                 return
             }
             self.cityName = placeMark.locality ?? ""
             let locationObj = PTLocation(latitude: self.lastLocation?.coordinate.latitude ?? 0.0, longitude: self.lastLocation?.coordinate.longitude ?? 0.0, city: placeMark.locality ?? "")
             UserDefaults.standard.save(customObject: locationObj, inKey: PTConstantKey.location)
         }
     }
}

struct PTLocation: Codable {
    let latitude: Double
    let longitude: Double
    let city: String
}
