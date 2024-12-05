//
//  PTAnalyticsManager.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 05/12/24.
//

import Foundation
import Firebase

class PTAnalyticsManager {
    
    class func logEvent(eventName name: String = AnalyticsEventSelectItem, parameter prams: Dictionary<String, Any>) {
        Analytics.logEvent(name, parameters: prams)
    }
}
