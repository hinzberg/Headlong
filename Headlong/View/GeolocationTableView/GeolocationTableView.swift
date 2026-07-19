//  GeolocationTableView.swift
//  Headlong
//  Created by Holger Hinzberg on 19.07.26.

import SwiftUI

struct GeolocationTableView: View {
    
    @EnvironmentObject  var geocodeRepository : GeocodeLocationRepository // alt
    @Environment(\.modelContext) private var modelContext
    
    @State private var geolocationRepositoy =  GeolocationRepository.shared
    @State private var searchText = ""
    
    var body: some View
    {
        VStack {
            NavigationView {
                    
               List {
                    ForEach (self.geolocationRepositoy.fetchAll(), id:\.id) { location in
                        
                        ZStack { // With this Zstack you can hide the disclosure indicator
                           NavigationLink(destination: StoredLocationMapView(geolocation: location) )
                            {
                                EmptyView()
                            }
                            GeolocationTableCellView(geolocation:location)
                        }
                        .listRowSeparator(.hidden)
                        // The Swipe actions
                        .swipeActions(edge: .trailing , allowsFullSwipe: true) {
                            Button {
                                withAnimation {
                                    do {
                                        try self.geolocationRepositoy.delete(location: location)
                                    } catch {
                                        print("Failed to delete location: \(error)")
                                    }
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
                    }
                }
                // List configuration
               .listStyle(.plain)
               .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search ...")
               .onChange(of: searchText) { oldValue, newValue in
                   print(newValue)
               }
                 
                                
              /*
                List {
                        ForEach(self.geocodeRepository.filledDateGroups, id:\.id) { dateGroup in
                            Section(header: GeocodeTableViewSectionHeader(headlineText: dateGroup.dateDescription) )
                            {
                                ForEach (dateGroup.geoCodeLocationViewModels, id:\.id) { locationVM in
                                    ZStack { // With this Zstack you can hide the disclosure indicator
                                        NavigationLink(destination: StoredLocationMapView(geocodeLocationVM: locationVM) ) {
                                            EmptyView()
                                        }
                                        GeocodeLocationTableCellView(locationVM: locationVM)
                                    }
                                    // The Swipe actions
                                    .swipeActions(edge: .trailing , allowsFullSwipe: true) {
                                        Button {
                                            withAnimation {
                                                self.geocodeRepository.delete(locationVM: locationVM)
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
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .searchable(
                        text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search ...")
                    .onChange(of: searchText) { searchText in
                        print(searchText)
                    }
                */
                .navigationBarTitle("Headlong", displayMode: .inline)
                .navigationTitle("Back")
                .toolbar {
                    NavigationLink (destination: AddLocationMapView()) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        let geocodeRepository = GeocodeLocationRepository(context: viewContext)
        
        GeolocationTableView()
            .environmentObject(geocodeRepository)
    }
}
