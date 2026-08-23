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
    @State var isPresenting = false
    
    var body: some View {
        
        TabView(selection: $selection)
        {
            Tab("Locations", systemImage: "list.dash", value: .locations) {
                GeolocationTableView()
            }
            
            Tab("Settings", systemImage: "gear", value: .settings) {
                SettingsView()
            }
            
            Tab("Add New", systemImage: "move.3d", value: .view3d) { // Make this role: .prominent in iOS 27
                EmptyView()
            }
        }
        .accentColor(.cocoaBlue)
        .onChange(of: selection) {
            if (selection == .view3d) {
                isPresenting = true
            } else {
                self.oldSelection = selection
            }
        }
        .sheet(isPresented: $isPresenting, onDismiss: {
            self.selection = self.oldSelection
        }) {
            testSheet
        }
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
