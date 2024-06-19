//
//  PTFont.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 13/06/24.
//

import Foundation
import UIKit
import SwiftUI

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

extension Font {
    public static let PTButtonTitle = Font.custom("Mukta-Bold", size: 25, relativeTo: .largeTitle)
    public static let PTPrayerCell = Font.custom("Mukta-Medium", size: 20, relativeTo: .body)

//    public static let titleCustom = Font.custom("Lobster-Regular", size: 28, relativeTo: .title)
//    public static let title2Custom = Font.custom("Lobster-Regular", size: 22, relativeTo: .title2)
//    public static let title3Custom = Font.custom("Lobster-Regular", size: 20, relativeTo: .title3)
//    public static let headlineCustom = Font.custom("Lobster-Regular", size: 17, relativeTo: .headline)
//    public static let subheadlineCustom = Font.custom("Lobster-Regular", size: 15, relativeTo: .subheadline)
//    public static let bodyCustom = Font.custom("SyneMono-Regular", size: 17, relativeTo: .body)
//    public static let calloutCustom = Font.custom("SyneMono-Regular", size: 16, relativeTo: .callout)
//    public static let footnoteCustom = Font.custom("SyneMono-Regular", size: 13, relativeTo: .footnote)
//    public static let captionCustom = Font.custom("SyneMono-Regular", size: 12, relativeTo: .caption)
//    public static let caption2Custom = Font.custom("SyneMono-Regular", size: 11, relativeTo: .caption2)
}
