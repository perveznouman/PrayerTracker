//
//  Prayer.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 20/06/24.
//

import Foundation

struct PTTodaysPrayer: Identifiable {
    var id: String
    var name: String
    var isOffered: Bool
    var isEnabled: Bool
    var time: String
    var date: String
    
    init(id: String = "", name: String, isOffered: Bool, isEnabled: Bool = true, time: String, date: Date) {
        self.id = date.BHLocalStorageFormat + "-" + name
        self.name = name
        self.isOffered = isOffered
        self.isEnabled = Date().isPassedTime(time)
        self.time = time
        self.date = date.BHLocalStorageFormat
    }
}

struct PTTodaysPrayerAggregatedData: Identifiable {
    var id = UUID()
    var category: String
    var count: Int
}
