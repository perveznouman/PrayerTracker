//
//  PTDailyPrayerData.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 14/08/24.
//

import Foundation
import SwiftData

@Model
class PTDailyPrayerData {
    
    @Attribute(.unique) let id: String!
    let name: String
    let offered: Bool
    let date: String
    
    init(name: String, offered: Bool, date: Date) {
        self.id = date.BHLocalStorageFormat + "-" + name
        self.name = name
        self.offered = offered
        self.date = date.BHLocalStorageFormat
    }
    
    static func makeDatePredicate(for date: Date) -> Predicate<PTDailyPrayerData> {
        let dateString = date.BHLocalStorageFormat
        return #Predicate<PTDailyPrayerData> { dailyData in
            dailyData.date == dateString
        }
//        return #Predicate { $0.date == dateString }
    }
}
