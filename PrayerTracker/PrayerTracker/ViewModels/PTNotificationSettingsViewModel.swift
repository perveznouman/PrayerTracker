//
//  PTNotificationSettingsViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 15/10/24.
//
import Foundation

class PTNotificationSettingsViewModel: ObservableObject {
    
    @Published var reminders: [PTNotificationSettings] = [PTNotificationSettings(title: "5:00 AM", isON: true),
                                               PTNotificationSettings(title: "6:00 AM", isON: true),
                                               PTNotificationSettings(title: "7:00 AM", isON: true),
                                               PTNotificationSettings(title: "8:00 AM", isON: true),
                                               PTNotificationSettings(title: "9:00 AM", isON: true),
                                               PTNotificationSettings(title: "10:00 AM", isON: true),
                                               PTNotificationSettings(title: "8:00 PM", isON: true),
                                               PTNotificationSettings(title: "9:00 PM", isON: true),
                                               PTNotificationSettings(title: "10:00 PM", isON: true),
                                               PTNotificationSettings(title: "11:00 PM", isON: true),
                                               PTNotificationSettings(title: "12:00 AM", isON: true)]
    
    @Published var prayerReminder: [PTNotificationSettings] = [PTNotificationSettings(title: "fajr", isON: true),
                                                    PTNotificationSettings(title: "zuhar", isON: true),
                                                    PTNotificationSettings(title: "asar", isON: true),
                                                    PTNotificationSettings(title: "maghrib", isON: true),
                                                    PTNotificationSettings(title: "esha", isON: true)]
}
