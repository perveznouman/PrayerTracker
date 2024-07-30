//
//  PTPrayerTimeResponse.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 26/07/24.
//

import Foundation

struct PTPrayerTimeResponse: Codable {
    let code: Int
    let status: String
    let data: [String: [PTPrayerData]]
}

struct PTPrayerData: Codable {
    let timings: PTTimings
}

struct PTTimings: Codable {
    let fajr, dhuhr, asr, maghrib, isha: String

    enum CodingKeys: String, CodingKey {
        case fajr = "Fajr"
        case dhuhr = "Dhuhr"
        case asr = "Asr"
        case maghrib = "Maghrib"
        case isha = "Isha"
        
//        case sunrise = "Sunrise"
//        case sunset = "Sunset"
//        case imsak = "Imsak"
//        case midnight = "Midnight"
//        case firstthird = "Firstthird"
//        case lastthird = "Lastthird"
    }
}
