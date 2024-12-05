//
//  PrayerTrackerApp.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 07/03/24.
//

import SwiftUI
import SwiftData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.max)
        return true
    }
}

@main
struct PrayerTrackerApp: App {

    @State private var dataManager: PTSwiftDataManager = PTSwiftDataManager()
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            PTRootView()
                .environment(dataManager)
        }
        .onChange(of: scenePhase, { oldValue, newValue in
            switch newValue {
            case .active:
                notificationsAndLocation()
            case .background, .inactive: break
            @unknown default:
                print("None")
            }
        })
        .modelContainer(for: [PTUserPrayerData.self])
    }
    
    private func notificationsAndLocation() {
        let notificationVM = PTNotificationSettingsViewModel()
        notificationVM.clearNotification()
        notificationVM.scheduleReminderNotification(type: Notifications.allCases)
    }
    
    init() {
        let _ = PTLocationManager()
        guard let _ = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last else { return }
    }
}
