//  DateViewModel.swift
//  Headlong
//  Created by Holger Hinzberg on 18.06.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.

import Swift
import Foundation

public class DateGroup
{
    public var id = UUID()
    public let startDate : Date
    public let endDate : Date
    public let startDateFormated : String
    public let endDateFormated : String
    public let startDateTimeFormated : String
    public let endDateTimeFormated : String
    public let dateDescription : String
    public var geoCodeLocationViewModels = [GeocodeLocationViewModel]()
    
    public init ( start : Date, end : Date, description : String) {
        self.startDate = start
        self.endDate = end
        self.dateDescription = description
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale.current
        
        startDateFormated = dateFormatter.string(from: startDate.localDate)
        endDateFormated = dateFormatter.string(from: endDate.localDate)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale.current
        
        startDateTimeFormated = dateFormatter.string(from: startDate.localDate)
        endDateTimeFormated = dateFormatter.string(from: endDate.localDate)
    }
}
