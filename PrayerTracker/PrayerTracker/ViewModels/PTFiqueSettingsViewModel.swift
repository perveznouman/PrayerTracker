//
//  PTFiqueSettingsViewModel.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 03/01/25.
//

import Foundation


class PTFiqueSettingsViewModel: ObservableObject {
    
    var fiques = PTFique.allCases
    var schools = PTSchool.allCases

    @Published var selectedFique: PTFique?
    @Published var selectedSchool: PTSchool?

    private var existingFique: PTFique?
    private var existingSchool: PTSchool?
    
    init() {
        self.selectedFique = PTFique(rawValue: UserDefaults.standard.retrieve(object: Int.self, fromKey: PTConstantKey.selectedFique) ?? 3)
        self.selectedSchool = PTSchool(rawValue: UserDefaults.standard.retrieve(object: Int.self, fromKey: PTConstantKey.selectedSchool) ?? 1)
        self.existingFique = selectedFique
        self.existingSchool = selectedSchool
    }
    
    public func saveUserPreference() {
        if(existingFique != selectedFique) {
            UserDefaults.standard.save(customObject: selectedFique?.rawValue, inKey: PTConstantKey.selectedFique)
            PTLocationManager().callPrayerTimingAPI()
            PTAnalyticsManager.logEvent(eventName:PTAnalyticsConstant.fiqueSetting.caseValue, parameter: [PTAnalyticsConstant.fiqueSetting.caseValue: selectedFique?.id ?? 3])
        }
        if(existingSchool != selectedSchool) {
            UserDefaults.standard.save(customObject: selectedSchool?.rawValue, inKey: PTConstantKey.selectedSchool)
            PTLocationManager().callPrayerTimingAPI()
            PTAnalyticsManager.logEvent(eventName:PTAnalyticsConstant.schoolSetting.caseValue, parameter: [PTAnalyticsConstant.schoolSetting.caseValue: selectedSchool?.id ?? 1])
        }
    }
}
