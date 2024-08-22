//
//  PTLocationViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 02/07/24.
//

import Foundation

class PTLocationViewModel: ObservableObject {
    
    static let shared: PTLocationViewModel = PTLocationViewModel()
    @Published var location: PTLocation?
    @Published var todaysPrayer: [PTTodaysPrayer] = [PTTodaysPrayer(name: "fajr", isOffered: false, isEnabled: true, time: "--", date:                                                      .now),
                                                     PTTodaysPrayer(name: "zuhar", isOffered: false, isEnabled: true, time: "--", date: .now),
                                                     PTTodaysPrayer(name: "asar", isOffered: false, isEnabled: true, time: "--", date: .now),
                                                     PTTodaysPrayer(name: "maghrib", isOffered: false, isEnabled: true, time: "--", date: .now),
                                                     PTTodaysPrayer(name: "esha", isOffered: false, isEnabled: true, time: "--", date: .now)]
    
    private init() {}
    
    func save(_ location: PTLocation) {
        self.location = location
        UserDefaults.standard.save(customObject: location, inKey: PTConstantKey.location)
    }
    
    func retrieve() -> PTLocation? {
        self.location = UserDefaults.standard.retrieve(object: PTLocation.self, fromKey: PTConstantKey.location)
        return self.location
    }
    
    func savePrayerTime(_ response: PTPrayerTimeResponse) {
        self.todaysPrayer = PTPrayerTimeResponseViewModel(prayerTimeResponse: response).timings?.prayers ?? []
        UserDefaults.standard.save(customObject: response, inKey: location?.city ?? "")
    }
    
    
    func retrievePrayerTime() -> [PTTodaysPrayer] {
        let pData = UserDefaults.standard.retrieve(object: PTPrayerTimeResponse.self, fromKey: location?.city ?? "")
        if (pData != nil) {
            self.todaysPrayer = PTPrayerTimeResponseViewModel(prayerTimeResponse: pData!).timings?.prayers ?? []
        }
        return self.todaysPrayer
    }
    
    func defaultPrayerTime(_ previousDate: Date) {
        todaysPrayer = [PTTodaysPrayer(name: "fajr", isOffered: false, isEnabled: true, time: "--", date: previousDate),
                        PTTodaysPrayer(name: "zuhar", isOffered: false, isEnabled: true, time: "--", date: previousDate),
                        PTTodaysPrayer(name: "asar", isOffered: false, isEnabled: true, time: "--", date: previousDate),
                        PTTodaysPrayer(name: "maghrib", isOffered: false, isEnabled: true, time: "--", date: previousDate),
                        PTTodaysPrayer(name: "esha", isOffered: false, isEnabled: true, time: "--", date: previousDate)]
    }
}


class PTPrayerTimeViewModel {
    
    private var locationViewModel: PTLocationViewModel = PTLocationViewModel.shared

    init() {}
    
    func prayerTime(date pickedDated: Date) {
        
        if !pickedDated.BHIsToday {
            locationViewModel.defaultPrayerTime(pickedDated)
        }
        else {
           let _ = locationViewModel.retrievePrayerTime()
        }
    }
}
