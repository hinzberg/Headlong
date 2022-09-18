//  HeadlongApp.swift
//  Headlong
//  Created by Holger Hinzberg on 14.10.21.

import SwiftUI
import Hinzberg_SwiftUI

@main
struct HeadlongApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let viewContext = CoreDataManager.shared.persistentContainer.viewContext
            let geocodeRepository = GeocodeLocationRepository(context: viewContext)
           
            MainView()
                .environmentObject(geocodeRepository)
                // .environment(\.managedObjectContext, viewContext)
        }
    }
}

class AppDelegate : NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
    {
        UINavigationBar.appearance().standardAppearance = CustomNavigationBarAppearance.DefaultAppearance
        UINavigationBar.appearance().compactAppearance = CustomNavigationBarAppearance.DefaultAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = CustomNavigationBarAppearance.DefaultAppearance
               
        UITableViewHeaderFooterView.appearance().tintColor = UIColor.clear
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
        UITabBar.appearance().backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 1.0, alpha: 1)
              
        return true
    }
}
