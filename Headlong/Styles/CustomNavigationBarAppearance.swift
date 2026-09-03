//  CustomNavigationBarAppearance.swift
//  Created by Holger Hinzberg on 18.06.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.
import SwiftUI

class CustomNavigationBarAppearance
{
    static func makeAppearance(for colorScheme: ColorScheme) -> UINavigationBarAppearance {
        
        let backgroundColor: Color = colorScheme == .dark ? Color.anthracite : Color.whiteSand
        let titleTextColor: Color = colorScheme == .dark ? Color.whiteSand : Color.veryPeri
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = UIColor(backgroundColor)
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(titleTextColor)]
        appearance.titleTextAttributes = [.foregroundColor: UIColor(titleTextColor)]
        
        return appearance
    }
}
