//
//  Prayer.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 20/06/24.
//

import Foundation

struct Prayer: Identifiable {
    var id = UUID()
    var name: String
    var isOffered: Bool
    var isEnabled: Bool
}

struct TodaysPrayerAggregatedData: Identifiable {
    var id = UUID()
    var category: String
    var count: Int
}
