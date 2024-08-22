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
    
    private init() {}
    
    func save(_ location: PTLocation) {
        self.location = location
        UserDefaults.standard.save(customObject: location, inKey: PTConstantKey.location)
    }
    
    func retrieve() -> PTLocation? {
        self.location = UserDefaults.standard.retrieve(object: PTLocation.self, fromKey: PTConstantKey.location)
        return self.location
    }
}

