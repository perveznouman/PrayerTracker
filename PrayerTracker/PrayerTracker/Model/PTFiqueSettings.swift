//
//  PTFiqueSettings.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 16/11/24.
//
import Foundation
import SwiftUI

enum PTFique: Int, CaseIterable, Equatable, Identifiable {
    
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
}


class PTFiqueSettings: Identifiable {
    
    let id: Int
    let title: String
    var isON: Bool
    
    init(_ fique: PTFique) {
        self.id = fique.rawValue
        self.title = String(describing: fique)
        self.isON = true
    }
}
