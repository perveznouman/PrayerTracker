//
//  PTLocationConfirmer.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 23/07/24.
//

import Foundation
import CoreLocation

class PTLocationConfirmer: NSObject, ObservableObject {
    private let distanceThreshold = 20000.0; // 20 km
    var currentLocation: CLLocation?
    var locationViewModel: PTLocationViewModel = PTLocationViewModel.shared
    @Published var todaysPrayer: [PTTodaysPrayer] = [PTTodaysPrayer(name: "fajr", isOffered: false, isEnabled: false, time: "--"),
                                                     PTTodaysPrayer(name: "zuhar", isOffered: false, isEnabled: false, time: "--"),
                                                     PTTodaysPrayer(name: "asar", isOffered: false, isEnabled: false, time: "--"),
                                                     PTTodaysPrayer(name: "maghrib", isOffered: false, isEnabled: false, time: "--"),
                                                     PTTodaysPrayer(name: "esha", isOffered: false, isEnabled: false, time: "--")] 
//    {
//        willSet {
//            self.objectWillChange.send()
//        }
//    }
    
    func isNotInRanger(_ newLocation: CLLocation) -> Bool {
        if currentLocation == nil {
            currentLocation = newLocation
            return true
        }
        if currentLocation!.distance(from: newLocation) > distanceThreshold {
            currentLocation = newLocation
            return true
        }
        return false
    }
    
    func callPrayerTimingAPI() {
        PTPrayerTimingRequester().getPrayerTimings(currentLocation!.coordinate.latitude, currentLocation!.coordinate.longitude) { vm in
            DispatchQueue.main.async {
                self.todaysPrayer = vm
            }
        }
                                                   
    }

}
