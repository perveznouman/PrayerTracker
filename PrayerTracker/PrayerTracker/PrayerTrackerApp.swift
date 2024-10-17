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
        .modelContainer(for: [PTUserPrayerData.self])
    }
    
    init() {
        
        let _ = PTLocationManager()
        PTNotificationSettingsViewModel().scheduleReminderNotification()
        guard let _ = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last else { return }
    }
}
