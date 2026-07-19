//  GeolocationRepositoryProtocol.swift
//  Headlong
//  Created by Holger Hinzberg on 04.01.25.
//  Copyright © 2025 Holger Hinzberg. All rights reserved.

protocol GeolocationRepositoryProtocol
{
    func fetchAll()  throws -> [Geolocation]
    func add(location: Geolocation)  throws
    func update(location: Geolocation)  throws
    func delete(location: Geolocation)  throws
}
