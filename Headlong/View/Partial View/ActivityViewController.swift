//  ShareSheet.swift
//  Headlong
//  Created by Holger Hinzberg on 26.05.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.

import SwiftUI
struct ActivityViewController: UIViewControllerRepresentable
{
    @AppStorage("sharePrefix") private var sharePrefix = "I am here:"
    @AppStorage("sharePostfix") private var sharePostfix = "Shared with Headlong App by Holger Hinzberg"
    
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    
    var location : Geolocation
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType] = [.openInIBooks, .saveToCameraRoll, .airDrop]
    let callback: Callback? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController
    {
        let locationText = self.getLocationShareDescription(location: self.location)
        let controller = UIActivityViewController( activityItems: [locationText], applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
    
    public func getLocationShareDescription(location : Geolocation) -> String
    {
        var locationText = ""
        if self.sharePrefix != "" {
            locationText += sharePrefix + "\n\n" }
        if  location.name != "" {
            locationText += (location.name ?? "") + "\n" }
        
        // if  address1 != "" { locationText += address1 + "\n" }
        // if  address2 != "" { locationText += address2 + "\n" }
        // if  neighborhood != "" { locationText += neighborhood + "\n" }
        // if  subAdministrativeArea != "" { locationText += subAdministrativeArea + "\n" }
        
        if  location.zipCode != "" && location.city == "" {
            locationText += (location.zipCode ?? "" ) + "\n" }
        if  location.zipCode == "" && location.city != "" {
            locationText += location.city ?? "" + "\n" }
        if  location.zipCode != "" && location.city != "" {
            locationText += (location.zipCode ?? "") + " " + (location.city ?? "") + "\n" }
        if  location.state != "" {
            locationText += location.state ?? "" + "\n" }
        if  location.country != "" {
            locationText += (location.country ?? "") + "\n" }
        
        locationText += "\n"
        
        if  location.latitude != 0 {
            locationText += "Latitude:  \(location.latitude)\n" }
        if  location.longitude != 0 {
            locationText += "Longitude:  \(location.longitude)\n" }
        
        if self.sharePostfix != "" {
            locationText += "\n" + sharePostfix + "\n" }
                
        return locationText
    }
    
    
    
}

struct TestActivityViewController: UIViewControllerRepresentable
{
    func makeUIViewController(context: Context) -> UIActivityViewController
    {
        let locationText = "Hello World"
        let controller = UIActivityViewController( activityItems: [locationText], applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}
