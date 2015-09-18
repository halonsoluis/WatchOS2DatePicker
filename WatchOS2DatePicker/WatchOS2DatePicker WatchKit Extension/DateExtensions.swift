//
//  DateExtensions.swift
//  WatchOS2DatePicker
//
//  Created by Hugo on 9/18/15.
//  Copyright © 2015 halonso. All rights reserved.
//

import Foundation

extension NSDate {
    
    var dayMonthYear: (Int, Int, Int) {
        let components = NSCalendar.currentCalendar().components([.Day, .Month, .Year], fromDate: self)
        return (components.day, components.month, components.year)
    }
    
    func numberOfDaysInMonth() -> Int {
        let cal = NSCalendar.currentCalendar()
        let days = cal.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: self)
        return days.length
    }
    
    static func buildDateFor(year: Int, month: Int, day: Int) -> NSDate {
        let c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        
        let gregorian = NSCalendar(identifier:NSCalendarIdentifierGregorian)
        let date = gregorian!.dateFromComponents(c)
        return date!
    }
    
    static func daysCountInMonth(year: Int, month: Int) -> Int {
        return NSDate.buildDateFor(year, month: month, day: 1).numberOfDaysInMonth()
    }
    
    func dateRepresentation()-> String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd-MMM-YYYY"
        formatter.timeZone = NSTimeZone.systemTimeZone()
        return formatter.stringFromDate(self)
    }
    
    static func getAllTreeDigitsMonthRepresentationForCurrentLocale() -> [(String, Int)]{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM"
        formatter.timeZone = NSTimeZone.systemTimeZone()
    
        var months: [(String, Int)] = []
        var cursorDate: NSDate
        for i in 1..<13 {
         cursorDate = NSDate.buildDateFor(2015, month: i, day: 1)
         months.append((formatter.stringFromDate(cursorDate), i ))
        }
        return months
    }
}