//
//  PrayerViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 20/06/24.
//

import Foundation

class PrayerViewModel: ObservableObject {
    
    @Published var prayers: [Prayer] = [Prayer(name: "fajr", isOffered: false, isEnabled: true),
                                        Prayer(name: "zuhar", isOffered: true, isEnabled: false),
                                        Prayer(name: "asar", isOffered: false, isEnabled: true),
                                        Prayer(name: "maghrib", isOffered: true, isEnabled: true),
                                        Prayer(name: "esha", isOffered: false, isEnabled: false)]
    
    var aggregatedData: [TodaysPrayerAggregatedData] {
        let offeredCount = prayers.filter { $0.isOffered }.count
        let notOfferedCount = prayers.filter { !$0.isOffered }.count
        return [TodaysPrayerAggregatedData(category: "Offered", count: offeredCount),
            TodaysPrayerAggregatedData(category: "Not Offered", count: notOfferedCount)]
    }
    
    init() {
//        prayers = [Prayer(name: "fajr", isOffered: false, isEnabled: true),
//                  Prayer(name: "zuhar", isOffered: true, isEnabled: false),
//                  Prayer(name: "asar", isOffered: false, isEnabled: true),
//                  Prayer(name: "maghrib", isOffered: true, isEnabled: true),
//                  Prayer(name: "esha", isOffered: false, isEnabled: false)]
        
//        aggregatedData = [TodaysPrayerAggregatedData(category: "Offered", count: prayers.filter { $0.isOffered }.count),
//            TodaysPrayerAggregatedData(category: "Not Offered", count: prayers.filter { !$0.isOffered }.count)]
    }
}
