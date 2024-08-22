//
//  PrayerViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 20/06/24.
//

import Foundation

class PTTodaysPrayerViewModel: ObservableObject {
    
    var prayers: [PTTodaysPrayer] = []
    
    var aggregatedData: [PTTodaysPrayerAggregatedData] {
        
        let locationViewModel: PTLocationViewModel = PTLocationViewModel.shared
        self.prayers = locationViewModel.todaysPrayer
        let offeredCount = prayers.filter { $0.isOffered && $0.isEnabled }.count
        let notOfferedCount = prayers.filter { !$0.isOffered && $0.isEnabled }.count
        let notOpened = prayers.filter { !$0.isEnabled }.count

        return [PTTodaysPrayerAggregatedData(category: "Offered", count: offeredCount),
                PTTodaysPrayerAggregatedData(category: "Not Offered", count: notOfferedCount),
                PTTodaysPrayerAggregatedData(category: "Wait", count: notOpened)]
    }
    
    init() {}
}

class PTDailyPrayerViewModel {
    
    func mapPrayer(prayers: [PTDailyPrayerData]) -> [PTTodaysPrayer] {
        let locationViewModel: PTLocationViewModel = PTLocationViewModel.shared
        var todaysPrayer = locationViewModel.todaysPrayer
        todaysPrayer = todaysPrayer.map { prayer in
            var updatedPrayer = prayer
            if let matchingPrayer = prayers.first(where: { $0.id == prayer.id }) {
                updatedPrayer.isOffered = matchingPrayer.offered
            }
            return updatedPrayer
        }
        return todaysPrayer
    }
}
