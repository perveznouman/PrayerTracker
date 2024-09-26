//
//  PTNotification.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 27/09/24.
//

import Foundation


struct PTNotification {
    let id: String
    let title: String
    let content: String
    let subTitle: String?
    let hour: Int
    let min: Int
    let repeats: Bool
}
