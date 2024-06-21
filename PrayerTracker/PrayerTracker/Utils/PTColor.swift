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
    
    static let PTAccentColor = UIColor(red: 8/255.0, green: 143/255.0, blue: 143/255.0, alpha: 1.0)
    public static var PTWhite: UIColor {
        return UIColor.white
    }
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
     rgb(8, 143, 143)
     rgb(9, 121, 105)
     rgb(175, 225, 175)
     */

    public static var PTAccentColor: Color {
        return Color(UIColor(red: 8/255.0, green: 143/255.0, blue: 143/255.0, alpha: 1.0))
    }

    public static var PTNavBarColor: Color {
        return Color(UIColor(red: 230/255.0, green: 255.0/255.0, blue: 140/255.0, alpha: 1.0))
    }
    
    public static var PTViewBackgroundColor: Color {
        return Color.black
    }
    
    public static var PTWhite: Color {
        return Color.white
    }
    
    static let PTAlmond = Color(hex: "EADBC8")
}
