//
//  PTNotificationSettingsViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 15/10/24.
//
import Foundation

@MainActor
class PTNotificationSettingsViewModel: ObservableObject {
    
    @Published var prayerReminder: [PTNotificationSettings]!
    @Published var isAuthorized: Bool = false
    
    private var notificationMgr: PTNotificationManager = .init()
    private var todaysPrayerTimings: [PTTodaysPrayer]?
    
    private func getPrayerReminderTime(_ type: Notifications) -> String {
        
        if todaysPrayerTimings == nil {
            todaysPrayerTimings = PTDailyPrayerViewModel.shared.retrievePrayerTime()
        }
        let time = todaysPrayerTimings?.filter{ $0.name == type.rawValue }.last?.time ?? ""
        return time
    }
    
    func updateReminderTime(_ time: Date = .now, ofType type: Notifications = .reminder) {
        
        var formattedTime: String = getPrayerReminderTime(type)
        switch type {
        case .fajr:
            UserDefaults.standard.save(customObject: formattedTime, inKey: PTConstantKey.fajarPrayerNotification)
        case .zuhar:
            UserDefaults.standard.save(customObject: formattedTime, inKey: PTConstantKey.duharPrayerNotification)
        case .asar:
            UserDefaults.standard.save(customObject: formattedTime, inKey: PTConstantKey.asarPrayerNotification)
        case .maghrib:
            UserDefaults.standard.save(customObject: formattedTime, inKey: PTConstantKey.maghribPrayerNotification)
        case .esha:
            UserDefaults.standard.save(customObject: formattedTime, inKey: PTConstantKey.eshaPrayerNotification)
        case .reminder:
            formattedTime = time.BHReminderStorageFormat
            UserDefaults.standard.save(customObject: formattedTime, inKey: PTConstantKey.dailyReminderNotification)
        }
        self.scheduleReminderNotification(type: [type])
    }
    
    func getReminderTime() -> [String] {
        let time = UserDefaults.standard.retrieve(object: String.self, fromKey: PTConstantKey.dailyReminderNotification)
        let hourMin = time?.components(separatedBy: ":") ?? ["21", "30"]
        return hourMin
    }
    
    func readableReminderTime(_ reminderTime: [String]) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(hour: Int(reminderTime[0])!, minute: Int(reminderTime[1])!)
        if let time = calendar.date(from: components) {
            return time
        }
        return nil
    }
    
    func updateReminderPermission(_ enabled: Bool, ofType type: Notifications = .reminder) {
        
        switch type {
        case .fajr:
            UserDefaults.standard.save(customObject: enabled, inKey: PTConstantKey.fajarReminderEnabled)
            enabled ? scheduleReminderNotification(type: [type]) : notificationMgr.removeUpcomingNotification(for: PTConstantKey.fajarPrayerNotification)
        case .zuhar:
            UserDefaults.standard.save(customObject: enabled, inKey: PTConstantKey.duharReminderEnabled)
            enabled ? scheduleReminderNotification(type: [type]) : notificationMgr.removeUpcomingNotification(for: PTConstantKey.duharPrayerNotification)
        case .asar:
            UserDefaults.standard.save(customObject: enabled, inKey: PTConstantKey.asarReminderEnabled)
            enabled ? scheduleReminderNotification(type: [type]) : notificationMgr.removeUpcomingNotification(for: PTConstantKey.asarPrayerNotification)
        case .maghrib:
            UserDefaults.standard.save(customObject: enabled, inKey: PTConstantKey.maghribReminderEnabled)
            enabled ? scheduleReminderNotification(type: [type]) : notificationMgr.removeUpcomingNotification(for: PTConstantKey.maghribPrayerNotification)
        case .esha:
            UserDefaults.standard.save(customObject: enabled, inKey: PTConstantKey.eshaReminderEnabled)
            enabled ? scheduleReminderNotification(type: [type]) : notificationMgr.removeUpcomingNotification(for: PTConstantKey.eshaPrayerNotification)
        case .reminder:
            UserDefaults.standard.save(customObject: enabled, inKey: PTConstantKey.dailyReminderEnabled)
            enabled ? scheduleReminderNotification(type: [type]) : notificationMgr.removeUpcomingNotification(for: PTConstantKey.dailyReminderNotification)
        }
    }
    
    func getReminderPermission(type: [Notifications] = [.reminder]) -> Bool {
        
        var isEnabled: Bool = true
        for t in type {
            switch t {
            case .fajr:
                isEnabled = UserDefaults.standard.retrieve(object: Bool.self, fromKey: PTConstantKey.fajarReminderEnabled) ?? true
            case .zuhar:
                isEnabled = UserDefaults.standard.retrieve(object: Bool.self, fromKey: PTConstantKey.duharReminderEnabled) ?? true
            case .asar:
                isEnabled = UserDefaults.standard.retrieve(object: Bool.self, fromKey: PTConstantKey.asarReminderEnabled) ?? true
            case .maghrib:
                isEnabled = UserDefaults.standard.retrieve(object: Bool.self, fromKey: PTConstantKey.maghribReminderEnabled) ?? true
            case .esha:
                isEnabled = UserDefaults.standard.retrieve(object: Bool.self, fromKey: PTConstantKey.eshaReminderEnabled) ?? true
            case .reminder:
                isEnabled = UserDefaults.standard.retrieve(object: Bool.self, fromKey: PTConstantKey.dailyReminderEnabled) ?? true
            }
        }
        return isEnabled
    }
    
    func scheduleReminderNotification(type: [Notifications] = [.reminder]) {
        
        for t in type {
            var hourMin = self.getPrayerReminderTime(t).components(separatedBy: ":")
            if t == .reminder {
                hourMin = self.getReminderTime()
            }
            if hourMin.count > 1 {
                self.isNotificationAuthorized { authorized in
                    if self.getReminderPermission(type: [t]) && authorized {
                        
                        switch t {
                        case .fajr:
                            let _ = self.notificationMgr.schedule(PTNotification(id: PTConstantKey.fajarPrayerNotification, title: NSLocalizedString("fajrReminder", comment: ""), content: NSLocalizedString("addEntryReminderMessage", comment: ""), subTitle: nil, hour: Int(hourMin[0])!, min: Int(hourMin[1])!, repeats: true))
                        case .zuhar:
                            let _ = self.notificationMgr.schedule(PTNotification(id: PTConstantKey.duharPrayerNotification, title: NSLocalizedString("zuharReminder", comment: ""), content: NSLocalizedString("addEntryReminderMessage", comment: ""), subTitle: nil, hour: Int(hourMin[0])!, min: Int(hourMin[1])!, repeats: true))
                            
                        case .asar:
                            let _ = self.notificationMgr.schedule(PTNotification(id: PTConstantKey.asarPrayerNotification, title: NSLocalizedString("asarReminder", comment: ""), content: NSLocalizedString("addEntryReminderMessage", comment: ""), subTitle: nil, hour: Int(hourMin[0])!, min: Int(hourMin[1])!, repeats: true))
                            
                        case .maghrib:
                            let _ = self.notificationMgr.schedule(PTNotification(id: PTConstantKey.maghribPrayerNotification, title: NSLocalizedString("maghribReminder", comment: ""), content: NSLocalizedString("addEntryReminderMessage", comment: ""), subTitle: nil, hour: Int(hourMin[0])!, min: Int(hourMin[1])!, repeats: true))
                            
                        case .esha:
                            let _ = self.notificationMgr.schedule(PTNotification(id: PTConstantKey.eshaPrayerNotification, title: NSLocalizedString("eshaReminder", comment: ""), content: NSLocalizedString("addEntryReminderMessage", comment: ""), subTitle: nil, hour: Int(hourMin[0])!, min: Int(hourMin[1])!, repeats: true))
                        case .reminder:
                            let _ = self.notificationMgr.schedule(PTNotification(id: PTConstantKey.dailyReminderNotification, title: NSLocalizedString("addEntryReminderTitle", comment: ""), content: NSLocalizedString("addEntryReminderMessage", comment: ""), subTitle: nil, hour: Int(hourMin[0])!, min: Int(hourMin[1])!, repeats: true))
                        }
                        
                    }
                }
            }
        }
    }
    
    func setPrayerNotificationToggle() {
        self.prayerReminder = [PTNotificationSettings(title: "fajr", isON: getReminderPermission(type: [.fajr])),
                               PTNotificationSettings(title: "zuhar", isON: getReminderPermission(type: [.zuhar])),
                               PTNotificationSettings(title: "asar", isON: getReminderPermission(type: [.asar])),
                               PTNotificationSettings(title: "maghrib", isON: getReminderPermission(type: [.maghrib])),
                               PTNotificationSettings(title: "esha", isON: getReminderPermission(type: [.esha]))]
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
    
    init() {
        setPrayerNotificationToggle()
    }
}
