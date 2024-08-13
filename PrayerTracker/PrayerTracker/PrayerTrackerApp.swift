//
//  PrayerTrackerApp.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 07/03/24.
//

import SwiftUI
import SwiftData

@main
struct PrayerTrackerApp: App {

    var body: some Scene {
        WindowGroup {
            PTRootView()
        }
        .modelContainer(for: [PTDailyPrayerData.self])
    }
}
