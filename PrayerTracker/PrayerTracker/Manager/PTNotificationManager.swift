//
//  PTNotificationManager.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 25/09/24.
//

import Foundation
import UserNotifications

class PTNotificationManager {
    
    init() {}
    
    init(_ notification: PTNotification) {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in            
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        var date = DateComponents()
        date.hour = Int(notification.hour)
        date.minute = Int(notification.min)
        
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString(notification.title, comment: "")
        content.body =  NSLocalizedString(notification.content, comment: "")
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
    
    func isPermitted(completion: @escaping (_ isAuthorized: Bool) -> Void) {
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if(settings.alertSetting == .enabled) {
                completion(true)
            }else{
                completion(false)
            }
        }
    }
}
