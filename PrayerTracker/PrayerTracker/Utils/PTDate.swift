//
//  PTDate.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 19/05/24.
//

import Foundation


extension Date {
    
    static func newEntryFormatter(date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return NSLocalizedString("today", comment: "")
        }
        else if calendar.isDateInYesterday(date) {
            return NSLocalizedString("yesterday", comment: "")
        }
        else if calendar.isDateInTomorrow(date) {
            return NSLocalizedString("tomorrow", comment: "")
        }
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        return formatter.string(from: date)
    }
   
   
    
    /*
   static func dayDifference(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date, to: Date())
        return (components.day ?? 0)
    }
    
    
     
     https://vikramios.medium.com/date-handling-in-swift-with-date-extensions-9642cbd76720
     
     func timeDifference(from date: Date) -> (hours: Int, minutes: Int, seconds: Int) {
             let calendar = Calendar.current
             let components = calendar.dateComponents([.hour, .minute, .second], from: date, to: self)
             return (components.hour ?? 0, components.minute ?? 0, components.second ?? 0)
         }
     
     func weekday() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            return formatter.string(from: self)
        }
     
     func startOfDay() -> Date {
            return Calendar.current.startOfDay(for: self)
        }

        func endOfDay() -> Date {
            let calendar = Calendar.current
            return calendar.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
        }
     
     func isPastDate() -> Bool {
            return self < Date()
        }

        func isFutureDate() -> Bool {
            return self > Date()
        }
     
     func age(from date: Date) -> Int {
             let calendar = Calendar.current
             let ageComponents = calendar.dateComponents([.year], from: date, to: self)
             return ageComponents.year ?? 0
         }
     
     */
    
}
