//
//  PTColor.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 20/05/24.
//

import Foundation
import UIKit
import SwiftUI




extension UIColor {
    
    convenience init(rgb: UInt) {
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
    
    convenience init(hex: String, alpha: CGFloat) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    static let accentGreenColor = UIColor(red: 205.0/255.0, green: 255.0/255.0, blue: 1.0/255.0, alpha: 1.0)
}

extension Color {
    
    init(hex: String) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b)
    }
    
    func toUIColor() -> UIColor {
        if let components = self.cgColor?.components {
            return UIColor(displayP3Red: components[0], green: components[1], blue: components[2], alpha: components[3])
        } else {
            return UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        }
    }
    /*
     https://colorhunt.co/
     F6EEC9
     7469B6
     EADBC8
     144 155 68
     230 250 140
     205 255 1
     */

    public static var accentGreenColor: Color {
        return Color(UIColor(red: 205.0/255.0, green: 255.0/255.0, blue: 1.0/255.0, alpha: 1.0))
    }

    public static var viewBackgroundColor: Color {
        return Color.white
    }
    static let almond = Color(hex: "EADBC8")
}
