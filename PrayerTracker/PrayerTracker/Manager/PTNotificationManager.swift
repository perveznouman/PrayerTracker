//
//  PTNotificationManager.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 25/09/24.
//

import Foundation
import UserNotifications

class PTNotificationManager {
    
    init(_ notification: PTNotification) {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Permission granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        var date = DateComponents()
        date.hour = Int(notification.hour)
        date.minute = Int(notification.min)
        
        let content = UNMutableNotificationContent()
        content.title = notification.title //NSLocalizedString("addEntryReminderTitle", comment: "")
        content.body =  notification.content //NSLocalizedString("addEntryReminderMessage", comment: "")
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: notification.repeats)
        let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Notification scheduled")
            }
        }
    }
}
