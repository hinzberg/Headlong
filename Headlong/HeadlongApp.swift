//  HeadlongApp.swift
//  Headlong
//  Created by Holger Hinzberg on 14.10.21.

import SwiftUI

@main
struct HeadlongApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate : NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UINavigationBar.appearance().tintColor = .white
        
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().backgroundColor = .systemBlue
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().barTintColor = .systemBlue
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UITableViewHeaderFooterView.appearance().tintColor = UIColor.clear
        
        return true
    }
}
