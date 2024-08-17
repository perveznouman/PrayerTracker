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
        
    var prayers: [PTDailyPrayerData] = []
    
    func fetchPrayers(for date: Date, withContext context: ModelContext) {
        let predicate = PTDailyPrayerData.makeDatePredicate(for: date)
        let request = FetchDescriptor<PTDailyPrayerData>(predicate: predicate)
        
        do {
            prayers = try context.fetch(request)
        } catch {
            print("Error fetching prayers: \(error)")
        }
    }
}
