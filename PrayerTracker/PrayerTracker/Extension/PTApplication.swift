//
//  PTWindow.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 24/11/24.
//

import UIKit

extension UIApplication {
    
    var keyWindow: UIWindow? {
        return self.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
    
}
