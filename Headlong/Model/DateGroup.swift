//  DateViewModel.swift
//  Headlong
//  Created by Holger Hinzberg on 18.06.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.

import Foundation

public class DateGroup
{
    public var id = UUID()
    public let dateDescription : String
    public var geoLocations = [Geolocation]()
    
    public init ( description : String) {
        self.dateDescription = description
    }
}
