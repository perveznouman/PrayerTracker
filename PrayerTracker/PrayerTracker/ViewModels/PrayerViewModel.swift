//
//  PrayerViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 20/06/24.
//

import Foundation

struct PrayerViewModel {
    var prayers: [Prayer]
    init() {
        prayers = [Prayer(name: "fajr", isOffered: false, isEnabled: true),
                  Prayer(name: "zuhar", isOffered: true, isEnabled: false),
                  Prayer(name: "asar", isOffered: false, isEnabled: true),
                  Prayer(name: "maghrib", isOffered: true, isEnabled: true),
                  Prayer(name: "esha", isOffered: false, isEnabled: false)]
    }
//    func prayerList() -> [Prayer] {
//        return prayers
//    }
}
