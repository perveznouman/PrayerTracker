//
//  PrayerViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 20/06/24.
//

import Foundation

class PrayerViewModel: ObservableObject {
    
    @Published var prayers: [Prayer] = [Prayer(name: "fajr", isOffered: false, isEnabled: true),
                                        Prayer(name: "zuhar", isOffered: true, isEnabled: true),
                                        Prayer(name: "asar", isOffered: false, isEnabled: true),
                                        Prayer(name: "maghrib", isOffered: false, isEnabled: false),
                                        Prayer(name: "esha", isOffered: false, isEnabled: false)]
    
    var aggregatedData: [TodaysPrayerAggregatedData] {
        let offeredCount = prayers.filter { $0.isOffered && $0.isEnabled }.count
        let notOfferedCount = prayers.filter { !$0.isOffered && $0.isEnabled }.count
        let notOpened = prayers.filter { !$0.isEnabled }.count

        return [TodaysPrayerAggregatedData(category: "Offered", count: offeredCount),
                TodaysPrayerAggregatedData(category: "Not Offered", count: notOfferedCount),
                TodaysPrayerAggregatedData(category: "Wait", count: notOpened)]
    }
    
    init() {}
}
