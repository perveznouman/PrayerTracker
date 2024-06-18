//
//  PTFont.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 13/06/24.
//

import Foundation
import UIKit

extension UIFont {
    
    /*
     Mukta
        Mukta-Regular
        Mukta-ExtraLight
        Mukta-Light
        Mukta-Medium
        Mukta-SemiBold
        Mukta-Bold
        Mukta-ExtraBold
     Mukta Mahee
        MuktaMahee-Regular
        MuktaMahee-Light
        MuktaMahee-Bold
     */
    
    static func availableFonts() {
        for family in UIFont.familyNames {
            NSLog("\(family)")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                NSLog("   \(name)")
            }
        }
    }
    
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
        
    static func mainFont(name fontName: String, ofSize size: CGFloat) -> UIFont {
        return customFont(name: fontName, size: size)
    }
    
    static func boldFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Mukta-Bold", size: size)
    }
}
