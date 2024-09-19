//
//  PTDailyPrayerData.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 14/08/24.
//

import Foundation
import SwiftData

@Model
class PTUserPrayerData {
    
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
    
    static func makeDatePredicate(for date: Date) -> Predicate<PTUserPrayerData> {
        let dateString = date.BHLocalStorageFormat
        return #Predicate<PTUserPrayerData> { dailyData in
            dailyData.date == dateString && dailyData.offered == true
        }
    }
    static func makeWeekPredicate() -> Predicate<PTUserPrayerData> {
        
        let startDate =  Date().startOfWeek
        let endDate =  Date()
        let startingDateString = startDate!.BHLocalStorageFormat
        let endingDateString = endDate.BHLocalStorageFormat
        return #Predicate<PTUserPrayerData> {
            ($0.date >= startingDateString && $0.date <= endingDateString) && ($0.offered == true)
        }
    }
}
