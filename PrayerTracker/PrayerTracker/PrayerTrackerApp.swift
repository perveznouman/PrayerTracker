//
//  PrayerTrackerApp.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 07/03/24.
//

import SwiftUI

@main
struct PrayerTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PTRootView()
//            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
