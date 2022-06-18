//  DateViewModel.swift
//  Headlong
//  Created by Holger Hinzberg on 18.06.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.

import Swift
import Foundation

public class DateViewModel {

    public let startDate : Date
    public let endDate : Date
    public let startDateFormated : String
    public let endDateFormated : String
    public let dateDescription : String
    
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
    }
}
