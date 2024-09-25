//
//  PTNotificationManager.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 25/09/24.
//

import Foundation
import UserNotifications

class PTNotificationManager {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Permission granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        var date = DateComponents()
        date.hour = 19
        date.minute = 02
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("addEntryReminderTitle", comment: "")
        content.body = NSLocalizedString("addEntryReminderMessage", comment: "")
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: "\(date.hour!)", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Notification scheduled")
            }
        }
    }
}
