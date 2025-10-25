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
    
    func insert(_ prayerData: PTUserPrayerData, withContext context: ModelContext) {
        context.insert(prayerData)
        do {
            try context.save()
        }
        catch {
            print(#file, #function, #line, "failed to insert into db")
        }
    }
    
    func fetchPrayerStats(_ stats: PTStats = .weekly, forContext context: ModelContext) -> [String: Int] {
                
        var predicate: Predicate<PTUserPrayerData>
        
        switch stats {
            case .weekly:
                predicate = PTUserPrayerData.makeWeekPredicate()
            case .monthly:
                predicate = PTUserPrayerData.makeMonthPredicate()
            case .yearly:
                predicate = PTUserPrayerData.makeYearPredicate()
        }
        
        let request = FetchDescriptor<PTUserPrayerData>(predicate: predicate)
        var statsData:[String: Int] = [:]
        do {
            var prayersData: [PTUserPrayerData] = []
            prayersData = try context.fetch(request)
            statsData = PTStatsViewModel().mapOfferedPrayerWithxAxis(prayers: prayersData, stats: stats)
        } catch {
            print("Error fetching prayers: \(error)")
        }
        return statsData

    }
}
