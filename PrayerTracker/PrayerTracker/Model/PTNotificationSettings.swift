//
//  PTNotificationSetting.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 15/10/24.
//

import SwiftUI

public enum Notifications: String, CaseIterable, Equatable {
    
    case fajr = "fajr"
    case zuhar = "zuhar"
    case asar = "asar"
    case maghrib = "maghrib"
    case esha = "esha"
    case reminder = "reminder"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

class PTNotificationSettings: Identifiable {
    let id = UUID()
    let title: String
    var isON: Bool
    
    init(title: String, isON: Bool) {
        self.title = title
        self.isON = isON
    }
}


