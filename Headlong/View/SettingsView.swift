//  SettingsView.swift
//  Headlong
//  Created by Holger Hinzberg on 01.12.21.

import SwiftUI

struct SettingsView: View {
    
    let mapTypes = ["Standard","Satellite","Hybrid"]
    
    @AppStorage("quicksave") private var quickSave = true
    @AppStorage("sharePrefix") private var sharePrefix = "I am here:"
    @AppStorage("sharePostfix") private var sharePostfix = "Shared with Headlong App by Holger Hinzberg"
    @AppStorage("mapType") private var mapType = "Standard"

    @State private var showImportSheet = false
    
    var body: some View {
        
        NavigationView {
            
            Form {
                Section(header: Text("Settings")
                    .font(.headline)
                    .foregroundColor(.veryPeri)  )
                {
                    Picker("Map Type", selection: $mapType ) {
                        ForEach(mapTypes, id: \.self) {
                            Text($0)}
                    }
                }
                
                Section(header: Text("Sharing")
                    .font(.headline)
                    .foregroundColor(.veryPeri)  )
                {
                    TextField("Share Prefix", text: $sharePrefix)
                    TextField("Share Postfix", text: $sharePostfix)
                }
                
                Section(header: Text("Location Data")
                    .font(.headline)
                    .foregroundColor(.veryPeri)  )
                {
                    ExportLocationsShareLink()
                    Button {
                        showImportSheet = true
                    } label: {
                        Label("Import Locations", systemImage: "square.and.arrow.down")
                    }
                    Button {
                        do {
                            try GeolocationRepository.shared.addSampleLandmarks()
                        } catch {
                            print("Failed to add sample locations: \(error)")
                        }
                    } label: {
                        Label("Add sample Locations", systemImage: "star")
                    }
                    Button {
                        do {
                            try GeolocationRepository.shared.deleteAll()
                        } catch {
                            print("Failed to delete all locations: \(error)")
                        }
                    } label: {
                        Label("Delete all Locations", systemImage: "trash")
                    }
                    .foregroundColor(.red)
                }
                
                Section(header: Text("About Headlong")
                    .font(.headline)
                    .foregroundColor(.veryPeri)  ) {
                        HStack {
                            Text("Version")
                            Spacer()
                            Text(GetVersionNumber())
                        }
                        HStack {
                            Text("Copyright")
                            Spacer()
                            Text("Holger Hinzberg")
                        }
                        HStack {
                            Text("Web")
                            Spacer()
                            Link("http://www.hinzberg.de", destination: URL(string: "http://www.hinzberg.de")!)
                        }
                    }
            }.navigationBarTitle("Settings", displayMode: .inline)
            .sheet(isPresented: $showImportSheet) {
                ImportSheetView()
            }
        }
    }
    
    func GetVersionNumber() -> String {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
        if let version = appVersion as? String
        {
            return version
        }
        return "Unkown"
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct ExportLocationsShareLink: View {
    var body: some View {
        if let json = try? GeolocationRepository.shared.exportAsJson() {
            ShareLink("Export Locations", item: json)
        }
    }
}
