//
//  PTNotificationManager.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 25/09/24.
//

import Foundation
import UserNotifications

class PTNotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter =  UNUserNotificationCenter.current()
    
    init(notification: PTNotification) {
        
        super.init()
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Permission granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        var date = DateComponents()
        date.hour = notification.hour
        date.minute = notification.min
        
        let content = UNMutableNotificationContent()
        content.title = notification.title //NSLocalizedString("addEntryReminderTitle", comment: "")
        content.body = notification.content //NSLocalizedString("addEntryReminderMessage", comment: "")
        if let subtitle = notification.subTitle  {
            content.subtitle = subtitle
        }
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
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent notification")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive notification")
    }
    
}
