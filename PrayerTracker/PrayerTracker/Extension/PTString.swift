//
//  PTString.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 19/07/24.
//

import Foundation

extension String {
    
    func escaped() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
    func replaceString(_ characters: String, by separator: String) -> String {
        let characterSet = CharacterSet(charactersIn: characters)
        return components(separatedBy: characterSet).joined(separator: separator)
    }
    
    func toDate(format: String = "MM-dd-yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
