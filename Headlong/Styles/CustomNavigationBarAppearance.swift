//  CustomNavigationBarAppearance.swift
//  Created by Holger Hinzberg on 18.06.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.
import SwiftUI

class CustomNavigationBarAppearance
{
    static private var instance : UINavigationBarAppearance?
    
    static var DefaultAppearance : UINavigationBarAppearance
    {
        if instance == nil
        {
            instance = UINavigationBarAppearance()
            // Backgroundcolor
            instance!.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 1.0, alpha: 1)
            // Font color for navigationBarTitleDisplayMode large
            instance!.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.cocoaBlue)]
            // Font color for navigationBarTitleDisplayMode inline
            instance!.titleTextAttributes = [.foregroundColor: UIColor(Color.cocoaBlue)]
        }
        return instance!
    }
}
