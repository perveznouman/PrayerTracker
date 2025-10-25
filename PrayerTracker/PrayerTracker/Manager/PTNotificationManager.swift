//
//  PTNotificationManager.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 25/09/24.
//

import Foundation
import UserNotifications

class PTNotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let _ = error {
                PTAnalyticsManager.logEvent(eventName:PTAnalyticsConstant.notificationPermission.rawValue, parameter: [PTAnalyticsConstant.notificationPermission.caseValue: 0])
                return
            }
            PTAnalyticsManager.logEvent(eventName:PTAnalyticsConstant.notificationPermission.rawValue, parameter: [PTAnalyticsConstant.notificationPermission.caseValue: 1])

        }
    }
    
    func schedule (_ notification: PTNotification) {
        
        var date = DateComponents()
        date.hour = Int(notification.hour)
        date.minute = Int(notification.min)
        
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString(notification.title, comment: "")
        content.body =  NSLocalizedString(notification.content, comment: "")
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: notification.repeats)
        let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
        self.notificationCenter.delegate = self
        notificationCenter.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
//                print(notification.id + "Notification scheduled at - " + "\(notification.hour) : \(notification.min)")
            }
        }
    }
    
    func removeUpcomingNotification(for id: String) {
        self.notificationCenter.delegate = self
        notificationCenter.getPendingNotificationRequests { (notificationRequests) in
            var identifiers: [String] = []
            for notification:UNNotificationRequest in notificationRequests {
                if notification.identifier == id {
                    identifiers.append(notification.identifier)
                }
            }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
            print("Removing notification for \(id)")
        }
    }
    
    func clearNotifications() {
        notificationCenter.removeAllDeliveredNotifications()
    }
    
    func isPermitted(completion: @escaping (_ isAuthorized: Bool) -> Void) {
        self.notificationCenter.delegate = self
        notificationCenter.getNotificationSettings { (settings) in
            if(settings.alertSetting == .enabled) {
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.banner)
    }
}
