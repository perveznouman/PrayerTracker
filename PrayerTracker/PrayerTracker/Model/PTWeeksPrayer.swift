//
//  PTWeeksPrayer.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 27/06/24.
//

import Foundation

//struct PTWeeksPrayer: Identifiable {
//    var id = UUID()
//    var day: String
//    var minutes: Double
//}

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
            xAxis = Array(stride(from: 1, to: days, by: 1)).map { String($0) }
            offered.removeAll()
            while (offered.count < xAxis.count) {
                offered.append(Int.random(in: 0...17))
            }
            yValues = stride(from: 0, to: 18, by: 1).map { $0 }

        case .yearly:
            xAxis = Calendar.current.shortMonthSymbols
            offered.removeAll()
            while (offered.count < xAxis.count) {
                offered.append(Int.random(in: 0...510))
            }
            yValues = stride(from: 0, to: 520, by: 30).map { $0 }
        }
    }

}
