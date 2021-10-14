//  ContentView.swift
//  Headlong
//  Created by Holger Hinzberg on 14.10.21.

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            List(0 ..< 10) { item in
                Text("I was here! \(item)")
                    .padding()
            }.listStyle(.plain)
                .navigationBarTitle("Headlong", displayMode: .inline)
                .toolbar {
                    NavigationLink (destination: MapDetailView()) {
                        Image(systemName: "plus.square")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
