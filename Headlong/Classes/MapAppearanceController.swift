//  MapAppearanceController.swift
//  Headlong
//  Created by Holger Hinzberg on 12.09.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.

import SwiftUI
import MapKit

public class MapAppearanceController
{
    @AppStorage("mapType") private var mapType = "Standard"
    
    static let shared = MapAppearanceController()
    
    private init() {
    }
    
    public func updateAppearance()
    {
        print(mapType)
        if mapType == "Standard" {
            MKMapView.appearance().mapType = .standard
        } else if mapType == "Satellite" {
            MKMapView.appearance().mapType = .satellite
        } else if mapType == "Hybrid" {
            MKMapView.appearance().mapType = .hybrid
        }
    }
}
