//  HeadlongApp.swift
//  Headlong
//  Created by Holger Hinzberg on 14.10.21.

import SwiftUI
import SwiftData
import Hinzberg_SwiftUI

@main
struct HeadlongApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
   // var moc = ApplicationModelContainer.create()
    
    var body: some Scene {
        WindowGroup {
           // let viewContext = CoreDataManager.shared.persistentContainer.viewContext
            //let geocodeRepository = GeocodeLocationRepository(context: viewContext)
           
            MainView()
              //  .environmentObject(GeolocationRepository(modelContext: moc.mainContext ))
                // .environment(\.managedObjectContext, viewContext)
        }
      // .modelContainer(moc)
    }
}

class AppDelegate : NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
    {
        let bgColor = UIColor(red: 176.0 / 255, green: 174.0 / 255,  blue: 243.0 / 255, alpha: 1)
        
        UINavigationBar.appearance().standardAppearance = CustomNavigationBarAppearance.DefaultAppearance
        UINavigationBar.appearance().compactAppearance = CustomNavigationBarAppearance.DefaultAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = CustomNavigationBarAppearance.DefaultAppearance
               
        UITableViewHeaderFooterView.appearance().tintColor = UIColor.clear
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
        UITabBar.appearance().backgroundColor = bgColor
        return true
    }
}
