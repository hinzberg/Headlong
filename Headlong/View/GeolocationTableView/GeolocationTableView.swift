//  GeolocationTableView.swift
//  Headlong
//  Created by Holger Hinzberg on 19.07.26.

import SwiftUI

struct GeolocationTableView: View {
    
    @ObservedObject private var geolocationRepositoy =  GeolocationRepository.shared
    @State private var searchText = ""
    @State private var addLocationSheetIsPresented = false
    
    private var dateGroups: [DateGroup] {
        let groups = self.geolocationRepositoy.fetchAllGroupedByDate()
        guard !searchText.isEmpty else { return groups }
        let query = searchText.lowercased()
        return groups.compactMap { group in
            let filteredLocations = group.geoLocations.filter { location in
                (location.name ?? "").lowercased().contains(query) ||
                (location.city ?? "").lowercased().contains(query) ||
                (location.country ?? "").lowercased().contains(query)
            }
            guard !filteredLocations.isEmpty else { return nil }
            group.geoLocations = filteredLocations
            return group
        }
    }
    
    var body: some View
    {
        VStack {
            NavigationView {
                
                Group {
                    if self.dateGroups.isEmpty {
                        ContentUnavailableView {
                            Label("No Locations", systemImage: "mappin.slash")
                        } description: {
                            Text("Save a location and it will appear here.")
                        }
                    } else {
                        List {
                            ForEach (self.dateGroups, id:\.id) { dateGroup in
                                
                                Section(header: GeocodeTableViewSectionHeader(headlineText: dateGroup.dateDescription) )
                                {
                                    ForEach (dateGroup.geoLocations, id:\.id) { location in
                                        
                                        ZStack { // With this Zstack you can hide the disclosure indicator
                                            NavigationLink(destination: StoredLocationMapView(geolocation: location) )
                                            {
                                                EmptyView()
                                            }
                                            GeolocationTableCellView(geolocation:location)
                                        }
                                        .listRowInsets(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                                        
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
                                            .tint(Color.veryPeri)
                                        }
                                    }
                                }
                            }
                        }
                        // List configuration
                        .listStyle(.plain)
                        .listRowBackground(Color.clear)
                        .listRowSpacing(3)
                        //.listRowSeparator(.hidden)
                        .environment(\.defaultMinListRowHeight, 1)
                    }
                }
                .searchable(
                    text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search ...")
                .onChange(of: searchText) { oldValue, newValue in
                    print(newValue)
                }
                .navigationBarTitle("Headlong", displayMode: .inline)
                .navigationTitle("Back")
                .toolbar {
                    Button {
                        addLocationSheetIsPresented = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
                .sheet(isPresented: $addLocationSheetIsPresented) {
                    AddLocationMapView()
                }
            }
        }.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        GeolocationTableView()
    }
}


