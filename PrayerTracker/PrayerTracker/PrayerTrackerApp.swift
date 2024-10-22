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
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            PTRootView()
                .environment(dataManager)
        }
        .onChange(of: scenePhase, { oldValue, newValue in
            switch newValue {
            case .active:
                notificationsAndLocation()
            case .background:
                print("background")
            case .inactive:
                print("inactive")
            @unknown default:
                print("None")
            }
        })
        .modelContainer(for: [PTUserPrayerData.self])
    }
    
    private func notificationsAndLocation() {
        let _ = PTLocationManager()
        PTNotificationSettingsViewModel().scheduleReminderNotification()
    }
    
    init() {
        guard let _ = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last else { return }
    }
}
