//
//  MainView.swift
//  Headlong
//
//  Created by Holger Hinzberg on 01.12.21.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            GeocodeTableView()
                .tabItem {
                    Label("Locations", systemImage: "list.dash")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }.accentColor(.cocoaBlue)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
