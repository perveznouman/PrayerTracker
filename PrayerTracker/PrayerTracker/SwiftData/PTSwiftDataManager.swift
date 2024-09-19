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
        
    var sortedData: [PTTodaysPrayer] = []

    func fetchDailyPrayers(for date: Date, withContext context: ModelContext) {
        var prayersData: [PTUserPrayerData] = []
        let predicate = PTUserPrayerData.makeDatePredicate(for: date)
        let request = FetchDescriptor<PTUserPrayerData>(predicate: predicate)
        
        do {
            prayersData = try context.fetch(request)
            sortedData = PTDailyPrayerViewModel.shared.mapOfferedPrayer(prayers: prayersData)
        } catch {
            print("Error fetching prayers: \(error)")
        }
    }
    
    func insert(_ pryerData: PTUserPrayerData, withContext context: ModelContext) {
        context.insert(pryerData)
    }
    
    func fetchWeeklyPrayers(forContext context: ModelContext) -> [String: Int] {
                
        let predicate = PTUserPrayerData.makeWeekPredicate()
        let request = FetchDescriptor<PTUserPrayerData>(predicate: predicate)
        var weeklyData:[String: Int] = [:]
        do {
            var prayersData: [PTUserPrayerData] = []
            prayersData = try context.fetch(request)
            weeklyData = PTStatsViewModel().mapWeeklyOfferedPrayer(prayers: prayersData)
        } catch {
            print("Error fetching prayers: \(error)")
        }
        return weeklyData

    }
}
