//
//  PTFiqueSettings.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 16/11/24.
//
import Foundation
import SwiftUI

protocol PTFiqueSettingsProtocol {
    var id: Int { get }
    var title: String { get }
}


enum PTFique: Int, CaseIterable, Identifiable, PTFiqueSettingsProtocol {
    
    case shia = 0
    case karachi
    case america
    case mwl
    case makkah
    case egypt
    case tehran
    case gulf
    case kuwait
    case qatar
    case singapore
    case france
    case turkey
    case russia
    case mcw
    case duabi
    case malaysia
    case tunisia
    case algeria
    case indonesia
    case morocco
    case lisboa
    case jordan

    var id: Int {
        return self.rawValue
    }
    
    var title: String {
        return String(describing: self)
    }
    
//    var isSelected: Bool {
//        return self.id == UserDefaults.standard.retrieve(object: Int.self, fromKey: PTConstantKey.selectedFique) ?? 3
//    }
    
//    func updateFique(_ selectedId: Int) {
//        UserDefaults.standard.save(customObject: selectedId, inKey: PTConstantKey.selectedFique)
//    }
    
//    func selectedItem () -> Int {
//        return UserDefaults.standard.retrieve(object: Int.self, fromKey: PTConstantKey.selectedFique) ?? 3
//    }
}


enum PTSchool: Int, CaseIterable, Identifiable, PTFiqueSettingsProtocol {
    
    case shafi = 0
    case hanafi
    
    var id: Int {
        return self.rawValue
    }
    
    var title: String {
        return String(describing: self)
    }
}
