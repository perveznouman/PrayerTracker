//
//  PTNotificationSetting.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 15/10/24.
//

import Foundation

class PTNotificationSettings: Identifiable {
    let id = UUID()
    let title: String
    var isON: Bool
    
    init(title: String, isON: Bool) {
        self.title = title
        self.isON = isON
    }
}


