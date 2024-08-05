//
//  PTTodayPrayerTimeViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 26/07/24.
//

import Foundation

class PTTodayPrayerTimeViewModel {
    
    let prayerTimeResponse: PTPrayerTimeResponse
    var timings: PTTimingsViewModel?

    init(prayerTimeResponse: PTPrayerTimeResponse) {
        self.prayerTimeResponse = prayerTimeResponse
        let allData = prayerTimeResponse.data
        let monthExpression = Date().BHMonth.replacingOccurrences(of: #"^([+-])?0+"#, with: "$1", options: .regularExpression) // removing preceding zeros
        let intDate = Int(Date().BHDate)
        for item in allData {
            if (item.key == monthExpression) {
               timings = PTTimingsViewModel(item.value[(intDate ?? 1) - 1].timings)
                return
            }
        }
    }
}

class PTTimingsViewModel {

    var prayers: [PTTodaysPrayer]?
    
    init(_ timings: PTTimings) {
        prayers = [PTTodaysPrayer(name: "fajr", isOffered: false, isEnabled: true, time: timings.fajr.replaceString(" (IST)", by: "")),
                   PTTodaysPrayer(name: "zuhar", isOffered: false, isEnabled: true, time: timings.dhuhr.replaceString(" (IST)", by: "")),
                   PTTodaysPrayer(name: "asar", isOffered: false, isEnabled: true, time: timings.asr.replaceString(" (IST)", by: "")),
                   PTTodaysPrayer(name: "maghrib", isOffered: false, isEnabled: true, time: timings.maghrib.replaceString(" (IST)", by: "")),
                   PTTodaysPrayer(name: "esha", isOffered: false, isEnabled: true, time: timings.isha.replaceString(" (IST)", by: ""))]
    }

}
