//
//  PTSwiftDataManager.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 14/08/24.
//

import Foundation
import SwiftData

@Observable
class PTSwiftDataManager {
        
    private var prayersData: [PTDailyPrayerData] = []
    var sortedData: [PTTodaysPrayer] = []

    func fetchPrayers(for date: Date, withContext context: ModelContext) {
        let predicate = PTDailyPrayerData.makeDatePredicate(for: date)
        let request = FetchDescriptor<PTDailyPrayerData>(predicate: predicate)
        
        do {
            prayersData = try context.fetch(request)
            sortedData = PTDailyPrayerViewModel().mapPrayer(prayers: prayersData)
        } catch {
            print("Error fetching prayers: \(error)")
        }
    }
}
