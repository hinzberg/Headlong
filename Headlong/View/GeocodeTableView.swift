//  ContentView.swift
//  Headlong
//  Created by Holger Hinzberg on 14.10.21.

import SwiftUI

struct GeocodeTableView: View {
    
    @EnvironmentObject  var geocodeRepository : GeocodeLocationRepository
    
    var body: some View {
        
        VStack {

            NavigationView {
                
                List {
                    ForEach (self.geocodeRepository.geoCodeLocations, id:\.id) { location in
                        
                        GeocodeLocationTableCellView(location: location)
                            .swipeActions(edge: .trailing , allowsFullSwipe: true) {
                                Button {
                                    withAnimation {
                                        self.geocodeRepository.delete(location: location)
                                    }
                                } label: { Label("Delete", systemImage: "trash.fill") }
                                .tint(.red)
                            }
                        
                        
                    }.listRowSeparatorTint( Color.cocoaBlue)
                }.listStyle(.plain)
                
                    .navigationBarTitle("Headlong", displayMode: .inline)
                    .navigationTitle("Back")
                
                    .toolbar {
                        NavigationLink (destination: MapDetailView()) {
                            Image(systemName: "plus.square")
                        }
                    }
            }
        }.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GeocodeTableView()
    }
}
