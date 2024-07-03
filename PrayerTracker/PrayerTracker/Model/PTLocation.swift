//
//  PTLocation.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 01/07/24.
//

import Foundation

struct PTLocation: Codable, Hashable {
    let latitude: Double
    let longitude: Double
    let city: String
    let country: String
}
