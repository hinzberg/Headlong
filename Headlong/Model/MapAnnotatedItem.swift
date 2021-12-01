//  MapAnnotatedItem.swift
//  Headlong
//  Created by Holger Hinzberg on 01.12.21.
//  Copyright © 2021 Holger Hinzberg. All rights reserved.

import Foundation
import MapKit

struct MapAnnotatedItem: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}
