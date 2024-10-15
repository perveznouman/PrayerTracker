//
//  PTNotificationSettingsViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 15/10/24.
//
import Foundation

class PTNotificationSettingsViewModel: ObservableObject {
    
    @Published var prayerReminder: [PTNotificationSettings] = [PTNotificationSettings(title: "fajr", isON: true),
                                                    PTNotificationSettings(title: "zuhar", isON: true),
                                                    PTNotificationSettings(title: "asar", isON: true),
                                                    PTNotificationSettings(title: "maghrib", isON: true),
                                                    PTNotificationSettings(title: "esha", isON: true)]
    
    func updateReminderTime(_ time: Date) {
        let formattedTime = time.BHReminderStorageFormat
        UserDefaults.standard.save(customObject: formattedTime, inKey: PTConstantKey.dailyReminderNotification)
    }
    
    func getReminderTime() -> [String] {
        let time = UserDefaults.standard.retrieve(object: String.self, fromKey: PTConstantKey.dailyReminderNotification)
        let hourMin = time?.components(separatedBy: ":") ?? ["21", "30"]
        return hourMin
    }
}
