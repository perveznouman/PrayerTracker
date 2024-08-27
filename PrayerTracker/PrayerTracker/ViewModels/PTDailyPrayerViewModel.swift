//
//  PrayerViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 20/06/24.
//

import Foundation

class PTDailyPrayerViewModel: ObservableObject {
  
    static let shared = PTDailyPrayerViewModel()
    
    let locationViewModel: PTLocationViewModel = PTLocationViewModel.shared
    
    @Published var prayers: [PTTodaysPrayer] = [PTTodaysPrayer(name: "fajr", isOffered: false, time: "--", date:.now),
                                                PTTodaysPrayer(name: "zuhar", isOffered: false, time: "--", date: .now),
                                                PTTodaysPrayer(name: "asar", isOffered: false, time: "--", date: .now),
                                                PTTodaysPrayer(name: "maghrib", isOffered: false, time: "--", date: .now),
                                                PTTodaysPrayer(name: "esha", isOffered: false, time: "--", date: .now)]

    
    var aggregatedData: [PTTodaysPrayerAggregatedData] {
        
        let offeredCount = prayers.filter { $0.isOffered && $0.isEnabled }.count
        let notOfferedCount = prayers.filter { !$0.isOffered && $0.isEnabled }.count
        let notOpened = prayers.filter { !$0.isEnabled }.count

        return [PTTodaysPrayerAggregatedData(category: "Offered", count: offeredCount),
                PTTodaysPrayerAggregatedData(category: "Not Offered", count: notOfferedCount),
                PTTodaysPrayerAggregatedData(category: "Wait", count: notOpened)]
    }
    
    func savePrayerTime(_ response: PTPrayerTimeResponse) {
        self.prayers = PTPrayerTimeResponseViewModel(prayerTimeResponse: response).timings?.prayers ?? []
        UserDefaults.standard.save(customObject: response, inKey: locationViewModel.location?.city ?? "")
    }
    
    func retrievePrayerTime() -> [PTTodaysPrayer] {
        let pData = UserDefaults.standard.retrieve(object: PTPrayerTimeResponse.self, fromKey: locationViewModel.location?.city ?? "")
        if (pData != nil) {
            self.prayers = PTPrayerTimeResponseViewModel(prayerTimeResponse: pData!).timings?.prayers ?? []
        }
        return self.prayers
    }
    
    func defaultPrayerTime(_ previousDate: Date) {
        self.prayers = [PTTodaysPrayer(name: "fajr", isOffered: false, time: "--", date: previousDate),
                        PTTodaysPrayer(name: "zuhar", isOffered: false, time: "--", date: previousDate),
                        PTTodaysPrayer(name: "asar", isOffered: false, time: "--", date: previousDate),
                        PTTodaysPrayer(name: "maghrib", isOffered: false, time: "--", date: previousDate),
                        PTTodaysPrayer(name: "esha", isOffered: false, time: "--", date: previousDate)]
    }
    
    func loadPrayerTime(date pickedDated: Date) {
        
        if !pickedDated.BHIsToday {
            self.defaultPrayerTime(pickedDated)
        }
        else {
           let _ = self.retrievePrayerTime()
        }
    }
    
    func mapOfferedPrayer(prayers: [PTDailyPrayerData]) -> [PTTodaysPrayer] {
       
        self.prayers = self.prayers.map { prayer in
            var updatedPrayer = prayer
            if prayer.isEnabled {
                if let matchingPrayer = prayers.first(where: { $0.id == prayer.id }) {
                    updatedPrayer.isOffered = matchingPrayer.offered
                }
                return updatedPrayer
            }
            return prayer
        }
        return self.prayers
    }
    
    private init() {}

}
