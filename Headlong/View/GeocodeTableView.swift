//  ContentView.swift
//  Headlong
//  Created by Holger Hinzberg on 14.10.21.

import SwiftUI

struct GeocodeTableView: View {
    
    @EnvironmentObject  var geocodeRepository : GeocodeLocationRepository
    @State private var searchText = ""
    
    init() {
        let customAppearance = UINavigationBarAppearance()
        // Backgroundcolor
        customAppearance.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 1.0, alpha: 1)
        // Font color for navigationBarTitleDisplayMode large
        customAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.cocoaBlue)]
        // Font color for navigationBarTitleDisplayMode inline
        customAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.cocoaBlue)]
        
        UINavigationBar.appearance().standardAppearance = customAppearance
        UINavigationBar.appearance().compactAppearance = customAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = customAppearance
    }
    
    
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
                        
                            .swipeActions(edge: .leading , allowsFullSwipe: true) {
                                Button {
                                    print("Navigate")
                                } label: {
                                    Label("Navigate", systemImage: "map.fill")
                                }
                                .tint(Color.cocoaBlue)
                            }
                                                
                    }//.listRowSeparatorTint( Color.cocoaBlue)
                     .listRowSeparator(.hidden)
                }.listStyle(.plain)
                
                    .searchable(
                        text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search ...")
                    .onChange(of: searchText) { searchText in
                        print(searchText)
                    }
                
                    .navigationBarTitle("Headlong", displayMode: .inline)
                    .navigationTitle("Back")
                
                    .toolbar {
                        NavigationLink (destination: MapDetailView()) {
                            Image(systemName: "plus.circle")
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
