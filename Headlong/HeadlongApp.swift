//  HeadlongApp.swift
//  Headlong
//  Created by Holger Hinzberg on 14.10.21.

import SwiftUI
import Hinzberg_Swift_SwiftUI

@main
struct HeadlongApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            //MapDetailView()
        }
    }
}

class AppDelegate : NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UINavigationBar.appearance().tintColor = UIColor(Color.cocoaBlue)
        
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().backgroundColor = UIColor.white
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.cocoaBlue)]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().barTintColor = UIColor(Color.cocoaBlue)
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.cocoaBlue)]
        
        UITableViewHeaderFooterView.appearance().tintColor = UIColor.clear
         
        return true
    }
}
