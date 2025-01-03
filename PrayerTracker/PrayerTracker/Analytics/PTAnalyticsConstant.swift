//
//  PTAnalyticsConstant.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 05/12/24.
//

import Foundation

enum PTAnalyticsConstant: String, Equatable, CaseIterable {
    

    case notificationPermission = "Notification_Permission" ///Int
    case locationPermission = "Location_Permission" ///Int
    case serviceResponse = "Service_Response"

    case dateButton = "Date_Selected" ///String
    case prayerMarked = "Prayer_Marked" ///Int
    case locationUpdate = "Location_Updated" ///String

    case historyTab = "History_Tab" ///String
    case weeklyTab = "Weekly"
    case monthlyTab = "Montly"
    case yearlyTab = "Yearly"

    case share = "Share_Pressed" ///String
    case fiqueSetting = "Fique_Setting" ///Int
    case schoolSetting = "School_Setting" ///Int
    case reminder = "Reminder_Switch" ///String
    case reminderTime = "Reminder_Time"
    case prayerNotification = "Prayer_Notification" ///Int
    case contact = "Contact_Pressed"

    case on = "ON"
    case off = "OFF"

    case NA = "NA"
    
    var caseValue: String { String(rawValue.replaceString(" ", by: "_")) }
}
