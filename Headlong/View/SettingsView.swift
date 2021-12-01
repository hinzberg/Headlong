//  SettingsView.swift
//  Headlong
//  Created by Holger Hinzberg on 01.12.21.

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("quicksave") private var quickSave = true
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section(header: Text("Settings")
                            .font(.headline)
                            .foregroundColor(.cocoaBlue)  ) {
                    
                    Toggle("Quick Save", isOn: $quickSave)
                        .tint(.cocoaBlue)
                }
                
                Section(header: Text("About Headlong")
                            .font(.headline)
                            .foregroundColor(.cocoaBlue)  ) {
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
