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
    @Published var todaysPrayer: [PTTodaysPrayer] = []
    
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
            self.todaysPrayer = vm
        }
                                                   
    }

}
