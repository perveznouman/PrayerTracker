//
//  PTLocationViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 02/07/24.
//

import Foundation

struct PTLocationViewModel {
    
    func save(_ location: PTLocation) {
        UserDefaults.standard.save(customObject: location, inKey: PTConstantKey.location)
    }
    
    func retrieve() -> PTLocation? {
        return UserDefaults.standard.retrieve(object: PTLocation.self, fromKey: PTConstantKey.location)
    }
}
