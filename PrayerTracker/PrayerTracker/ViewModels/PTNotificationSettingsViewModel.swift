//
//  PTNotificationSettingsViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 15/10/24.
//
import Foundation

@MainActor
class PTNotificationSettingsViewModel: ObservableObject {
    
    @Published var prayerReminder: [PTNotificationSettings] = [PTNotificationSettings(title: "fajr", isON: true),
                                                    PTNotificationSettings(title: "zuhar", isON: true),
                                                    PTNotificationSettings(title: "asar", isON: true),
                                                    PTNotificationSettings(title: "maghrib", isON: true),
                                                    PTNotificationSettings(title: "esha", isON: true)]
    @Published var isAuthorized: Bool = false
    
    private var notificationMgr: PTNotificationManager = .init()
    
    func updateReminderTime(_ time: Date) {
        let formattedTime = time.BHReminderStorageFormat
        UserDefaults.standard.save(customObject: formattedTime, inKey: PTConstantKey.dailyReminderNotification)
        self.scheduleReminderNotification()
    }
    
    func getReminderTime() -> [String] {
        let time = UserDefaults.standard.retrieve(object: String.self, fromKey: PTConstantKey.dailyReminderNotification)
        let hourMin = time?.components(separatedBy: ":") ?? ["21", "30"]
        return hourMin
    }
    
    func updateReminderPermission(_ enabled: Bool) {
        UserDefaults.standard.save(customObject: enabled, inKey: PTConstantKey.dailyReminderEnabled)
        if enabled {
            self.scheduleReminderNotification()
        }
        else {
            notificationMgr.removeUpcomingNotification(for: PTConstantKey.dailyReminderNotification)
        }
    }
    
    func getReminderPermission() -> Bool {
        let isEnabled = UserDefaults.standard.retrieve(object: Bool.self, fromKey: PTConstantKey.dailyReminderEnabled) ?? true
        return isEnabled
    }
    
    
    func scheduleReminderNotification() {
        
        let hourMin = self.getReminderTime()
        self.isNotificationAuthorized { authorized in
            if self.getReminderPermission() && authorized {
                let _ = self.notificationMgr.schedule(PTNotification(id: PTConstantKey.dailyReminderNotification, title: NSLocalizedString("addEntryReminderTitle", comment: ""), content: NSLocalizedString("addEntryReminderMessage", comment: ""), subTitle: nil, hour: Int(hourMin[0])!, min: Int(hourMin[1])!, repeats: true))
            }
        }
    }
    
    func clearNotification() {
        notificationMgr.clearNotifications()
    }
    
    func isNotificationAuthorized(completion: @escaping (Bool) -> Void) {
        notificationMgr.isPermitted(completion: { isAuthorized in
            DispatchQueue.main.async {
                self.isAuthorized = isAuthorized
                completion(isAuthorized)
            }
        })
    }
    
    init() {}
}
