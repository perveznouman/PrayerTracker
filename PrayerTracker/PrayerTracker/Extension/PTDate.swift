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
   
    func currentMonthDays() -> Int {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }

    func isPassedTime(_ time: String) -> Bool {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "HH:mm"

        if let timeToCompare = formatter.date(from: time) {
            let currentTimeString = formatter.string(from: .now)
            if let currentTime = formatter.date(from: currentTimeString) {
                if currentTime > timeToCompare {
                    return true
                } else {
                    return false
                }
            }
        }
        return true
    }
    
    var BHDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
    
    var BHDateGraph: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
    
    var BHMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: self)
    }
    
    var BHMonthEng: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }
    
    var BHYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: self)
    }
    
    var BHIsToday: Bool {
       return Calendar.current.isDateInToday(self)
    }
    
    var BHLocalStorageFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.string(from: self)
    }
    
    // https://stackoverflow.com/questions/46402684/how-to-get-start-and-end-of-the-week-in-swift
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
        else { return nil }
        return gregorian.date(byAdding: .day, value: 0, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) 
        else { return nil }
        return gregorian.date(byAdding: .day, value: 6, to: sunday)
    }

    func weekdayName() -> String {
        let calendar = Calendar.current
        let weekdayIndex = calendar.component(.weekday, from: self) - 1
        return calendar.shortStandaloneWeekdaySymbols[weekdayIndex]
    }
    
    func monthName() -> String {
        let calendar = Calendar.current
        let weekdayIndex = calendar.component(.month, from: self) - 1
        return calendar.shortMonthSymbols[weekdayIndex]
    }

    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }

    func startOfYear() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfYear() -> Date {
        return Calendar.current.date(byAdding: DateComponents(year: 1, day: -1), to: self.startOfYear())!
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
