//  GeolocationRepositoryProtocol.swift
//  Headlong
//  Created by Holger Hinzberg on 04.01.25.
//  Copyright © 2025 Holger Hinzberg. All rights reserved.

protocol GeolocationRepositoryProtocol
{
    func fetchLocations()  throws -> [Geolocation]
    func addLocation(location: Geolocation)  throws
    func updateLocation(location: Geolocation)  throws
    func deleteLocation(location: Geolocation)  throws
}
