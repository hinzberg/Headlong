//  MainView.swift
//  Headlong
//  Created by Holger Hinzberg

import SwiftUI

struct MainView: View {
    
    enum RootTab: Hashable {
        case locations, settings, view3d
    }
    
    @State private var selection: RootTab = .locations
    @State private var oldSelection: RootTab = .locations
    
    var body: some View {
        TabView(selection: $selection)
        {
            Tab("Locations", systemImage: "list.dash", value: .locations) {
                GeolocationTableView()
            }
            
            Tab("AR View", systemImage: "move.3d", value: .view3d) { // Make this role: .prominent in iOS 27
                testSheet
            }
            Tab("Settings", systemImage: "gear", value: .settings) {
                SettingsView()
            }
        }
        .accentColor(.veryPeri)
        .background(.red)
        .onChange(of: selection) {     }
    }
}

var testSheet : some View {
    VStack{
        Text("testing")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
