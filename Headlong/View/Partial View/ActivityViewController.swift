//  ShareSheet.swift
//  Headlong
//  Created by Holger Hinzberg on 26.05.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.

import SwiftUI
struct ActivityViewController: UIViewControllerRepresentable
{
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    
    let location : GeocodeLocationViewModel
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType] = [.openInIBooks, .saveToCameraRoll, .airDrop]
    let callback: Callback? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController
    {
        let locationText = location.getLocationShareDescription()
        let controller = UIActivityViewController( activityItems: [locationText], applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}
