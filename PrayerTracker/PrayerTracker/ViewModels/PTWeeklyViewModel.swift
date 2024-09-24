//
//  PTWeeklyViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 01/07/24.
//

import Foundation

class PTWeeklyViewModel: ObservableObject {
    
    var xAxis: [String] = Calendar.current.shortWeekdaySymbols
    @Published var offered: [Int] = [ 0, 0, 0, 0, 0, 0, 0]
    private(set) var yValues: [Int] = stride(from: 0, to: 6, by: 1).map { $0 }

    init() {}
    
    func setupStatsData(dataCount: [String:Int], stats:PTStats = .weekly) {
        switch stats {
        case .weekly:
            setupWeeklyData(dataCount: dataCount)
        case .monthly:
            setupMonthlyData(dataCount: dataCount)
        case .yearly:
            setupYearlyData(dataCount: dataCount)
        }
    }
    
    private func setupWeeklyData(dataCount: [String:Int]) {
        
        xAxis = Calendar.current.shortWeekdaySymbols
        offered.removeAll()
        while (offered.count < xAxis.count) {
            offered.append(0)
        }
        yValues = stride(from: 0, to: 6, by: 1).map { $0 }
        
        if !dataCount.isEmpty {
            for (index, element) in xAxis.enumerated() {
                if let matchingPrayer = dataCount.first(where: { $0.key == element }) {
                    offered[index] = matchingPrayer.value
                }
            }
        }
    }
    
    private func setupMonthlyData(dataCount: [String:Int]) {
        
        let days = Date().currentMonthDays()
        xAxis = Array(stride(from: 1, to: days + 1, by: 1)).map { String($0) }
        offered.removeAll()
        while (offered.count < xAxis.count) {
            offered.append(0)
        }
        yValues = stride(from: 0, to: 6, by: 1).map { $0 }
        
        if !dataCount.isEmpty {
            for (index, element) in xAxis.enumerated() {
                if let matchingPrayer = dataCount.first(where: { $0.key == element }) {
                    offered[index] = matchingPrayer.value
                }
            }
        }
    }
    
    private func setupYearlyData(dataCount: [String:Int]) {
        
        xAxis = Calendar.current.shortMonthSymbols
        offered.removeAll()
        while (offered.count < xAxis.count) {
            offered.append(0)
//            offered.append(Int.random(in: 0...155))
        }
        yValues = stride(from: 0, to: 165, by: 10).map { $0 }
        
        if !dataCount.isEmpty {
            for (index, element) in xAxis.enumerated() {
                if let matchingPrayer = dataCount.first(where: { $0.key == element }) {
                    offered[index] = matchingPrayer.value
                }
            }
        }
    }
}


class PTStatsViewModel {
        
    func mapOfferedPrayerWithxAxis(prayers: [PTUserPrayerData], stats: PTStats) -> [String: Int] {
        
        var groupedPrayers: [String: [PTUserPrayerData]] 

        switch stats {
        case .weekly:
            groupedPrayers = Dictionary(grouping: prayers, by: { prayer in
                prayer.date.toDate()?.weekdayName() ?? "Unknown"
            })
        case .monthly:
            groupedPrayers = Dictionary(grouping: prayers, by: { prayer in
                prayer.date.toDate()?.BHDateGraph ?? "--"
            })
        case .yearly:
            groupedPrayers = Dictionary(grouping: prayers, by: { prayer in
                prayer.date.toDate()?.monthName() ?? "Unknown"
            })
        }
        
        let groupCount = groupedPrayers.mapValues { $0.count }
        return groupCount
    }
}
