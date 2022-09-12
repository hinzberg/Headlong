//  GeocodeTableView.swift
//  Headlong
//  Created by Holger Hinzberg on 14.10.21.

import SwiftUI

struct GeocodeTableView: View {
    
    @EnvironmentObject  var geocodeRepository : GeocodeLocationRepository
    @State private var searchText = ""
    
    init() {
        UINavigationBar.appearance().standardAppearance = CustomNavigationBarAppearance.DefaultAppearance
        UINavigationBar.appearance().compactAppearance = CustomNavigationBarAppearance.DefaultAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = CustomNavigationBarAppearance.DefaultAppearance
    }
    
    var body: some View {
        
        VStack {
            
            NavigationView {
                
                List {
                    ForEach(self.geocodeRepository.filledDateGroups, id:\.id) { dateGroup in
                        Section(header: GeocodeTableViewSectionHeader(headlineText: dateGroup.dateDescription) )
                        {
                            ForEach (dateGroup.geoCodeLocationViewModels, id:\.id) { locationVM in
                                NavigationLink(destination: StoredLocationMapView(geocodeLocationVM: locationVM) ) {
                                    GeocodeLocationTableCellView(locationVM: locationVM)
                                }
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
                    /*
                     ForEach (dateGroup.geoCodeLocationViewModels, id:\.id) { locationVM in
                     NavigationLink(destination: StoredLocationMapView(geocodeLocationVM: locationVM) ) {
                     GeocodeLocationTableCellView(locationVM: locationVM)
                     }
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
                     */
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
        GeocodeTableView()
    }
}
