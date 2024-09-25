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

           // 2. Create the content for the notification
           let content = UNMutableNotificationContent()
           content.title = "Reminder"
           content.body = "Don't forget to check the app!"
           content.sound = UNNotificationSound.default

           // 3. Set up a trigger for the notification
           // For example, 10 seconds from now
           let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (10), repeats: false)

           // 4. Create the request
           let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

           // 5. Add the request to the notification center
           UNUserNotificationCenter.current().add(request) { error in
               if let error = error {
                   print(error.localizedDescription)
               } else {
                   print("Notification scheduled")
               }
           }
    }
}
