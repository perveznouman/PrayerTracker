//
//  PTLocationConfirmer.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 23/07/24.
//

import Foundation
import CoreLocation

class PTLocationConfirmer: NSObject {
    private let distanceThreshold = 10000.0; // 10 km

    var currentLocation: CLLocation?
    
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

}
