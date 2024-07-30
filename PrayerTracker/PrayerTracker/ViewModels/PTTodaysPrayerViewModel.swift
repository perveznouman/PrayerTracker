//
//  PrayerViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 20/06/24.
//

import Foundation

class PTTodaysPrayerViewModel: ObservableObject {
    
    @Published var prayers: [PTTodaysPrayer] = [PTTodaysPrayer(name: "fajr", isOffered: false, isEnabled: true, time: "--"),
                                        PTTodaysPrayer(name: "zuhar", isOffered: true, isEnabled: true, time: "--"),
                                        PTTodaysPrayer(name: "asar", isOffered: false, isEnabled: true, time: "--"),
                                        PTTodaysPrayer(name: "maghrib", isOffered: false, isEnabled: false, time: "--"),
                                        PTTodaysPrayer(name: "esha", isOffered: false, isEnabled: false, time: "--")]
    
    var aggregatedData: [PTTodaysPrayerAggregatedData] {
        let offeredCount = prayers.filter { $0.isOffered && $0.isEnabled }.count
        let notOfferedCount = prayers.filter { !$0.isOffered && $0.isEnabled }.count
        let notOpened = prayers.filter { !$0.isEnabled }.count

        return [PTTodaysPrayerAggregatedData(category: "Offered", count: offeredCount),
                PTTodaysPrayerAggregatedData(category: "Not Offered", count: notOfferedCount),
                PTTodaysPrayerAggregatedData(category: "Wait", count: notOpened)]
    }
    
    init() {}
}
