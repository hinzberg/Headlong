//  Date+Extension.swift
//  Created by Holger Hinzberg on 18.06.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.

import Foundation

extension Date {
    
    var startOfWeek: Date? {
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
        //return calendar.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let calendar = Calendar.current
        guard let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return calendar.date(byAdding: .day, value: 6, to: sunday)
    }
    
    var startOfMonth : Date? {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))
    }
    
    var endOfMonth : Date? {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth!)
    }
    
    var startOfYear : Date? {
        let year = Calendar.current.component(.year, from: self)
        let startOfYear = Calendar.current.date(from: DateComponents(year: year, month: 1, day: 1) )
        return startOfYear
    }
    
    var endOfYear : Date? {
        let year = Calendar.current.component(.year, from: self)
        let lastOfYear = Calendar.current.date(from: DateComponents(year: year, month: 12, day: 31))
        return lastOfYear
    }
    
    var zero : Date? {
        let year = Calendar.current.date(from: DateComponents(year: 0, month: 1, day: 1))
        return year
    }
        
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    var localDate : Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: self) else {return Date()}
        return localDate
    }
}
