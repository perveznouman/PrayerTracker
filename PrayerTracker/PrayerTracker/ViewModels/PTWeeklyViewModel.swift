//
//  PTWeeklyViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 01/07/24.
//

import Foundation

class PTWeeklyViewModel {
    
    var xAxis: [String] = Calendar.current.shortWeekdaySymbols
    var offered: [Int] = [ 3, 5, 1, 0, 2, 4, 5]
    var yValues: [Int] = stride(from: 0, to: 6, by: 1).map { $0 }

    
    init(_ statsType: PTStats) {
        
        switch statsType {
        case .weekly:
            xAxis = Calendar.current.shortStandaloneWeekdaySymbols
            offered.removeAll()
            while (offered.count < xAxis.count) {
                offered.append(Int.random(in: 0...5))
            }
            yValues = stride(from: 0, to: 6, by: 1).map { $0 }
            
        case .monthly:
            let days = Date().currentMonthDays()
            xAxis = ["Week1", "Week2", "Week3", "Week4"]
            offered.removeAll()
            while (offered.count < xAxis.count) {
                offered.append(Int.random(in: 0...35))
            }
            yValues = stride(from: 0, to: 40, by: 5).map { $0 }

        case .yearly:
            xAxis = Calendar.current.shortMonthSymbols
            offered.removeAll()
            while (offered.count < xAxis.count) {
                offered.append(Int.random(in: 0...180))
            }
            yValues = stride(from: 0, to: 190, by: 10).map { $0 }
        }
    }
}
