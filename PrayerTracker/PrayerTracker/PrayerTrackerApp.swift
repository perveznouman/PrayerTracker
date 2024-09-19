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

    @State private var dataManager: PTSwiftDataManager = PTSwiftDataManager()

    var body: some Scene {
        WindowGroup {
            PTRootView()
                .environment(dataManager)
        }
        .modelContainer(for: [PTDailyPrayerData.self])
    }
    
    init() {
        guard let appSupportDir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last else { return }
        print(appSupportDir)
    }
}
