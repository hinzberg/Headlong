//  HeadlongApp.swift
//  Headlong
//  Created by Holger Hinzberg on 14.10.21.

import SwiftUI
import SwiftData
import Hinzberg_SwiftUI

@main
struct HeadlongApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
        
    var body: some Scene {
        WindowGroup {
            MainView()
                .dynamicNavigationBarAppearance()
        }
    }
}

class AppDelegate : NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
    {
        return true
    }
}

import UIKit

extension View {
    /// Applies a custom navigation bar appearance modifier that updates based on the system color scheme.
    func dynamicNavigationBarAppearance() -> some View {
        self.modifier(NavigationBarAppearanceUpdater())
    }
}

private struct NavigationBarAppearanceUpdater: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    /// Updates the view by applying the navigation bar appearance and reacting to color scheme changes.
    func body(content: Content) -> some View {
        content
            .onAppear(perform: applyAppearance)
            .onChange(of: colorScheme) { applyAppearance() }
    }

    /// Configures UINavigationBar appearance to match the current system color scheme.
    private func applyAppearance()
    {
        print("Color Scheme is \(colorScheme)")
        
        let appearance = CustomNavigationBarAppearance.makeAppearance(for: colorScheme)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
     
        //UITableViewHeaderFooterView.appearance().tintColor = UIColor.clear
        
        //let searchTextColor =  colorScheme == .dark ? Color.blue : Color.red
        //let searchBackgroundColor =  colorScheme == .dark ? Color.red : Color.white
        //UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor(searchBackgroundColor)
        //UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor(searchTextColor)
        //UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(searchTextColor)]
        //UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "placeholder text", attributes: [NSAttributedString.Key.foregroundColor: UIColor(searchTextColor)])
    }
}

