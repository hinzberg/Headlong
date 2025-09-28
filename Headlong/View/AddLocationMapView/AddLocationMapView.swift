//  MapDetailView.swift
//  Headlong
//  Created by Holger Hinzberg on 14.10.21.

import SwiftUI
import MapKit

struct AddLocationMapView: View {
    
    @AppStorage("mapType") private var mapType = "Standard"
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject  var mapController = AddLocationMapViewController()
    
    @Environment(\.modelContext) private var modelContext
    @State private var geolocationRepositoy =  GeolocationRepository.shared
    
    @State var shareSheetIsPresented = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        VStack {
            // Map
            
            ZStack {
                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                
                // Button stack over map
                VStack {
                    Spacer()
                    HStack {
                        Button() {
                            self.submitButton()
                        } label: {
                            Text("Save")
                                .frame(width:80)
                        }
                        .buttonStyle(.glass)
                        .tint(.blue)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0) )
                        
                        Button() {
                            self.cancelButton()
                        } label: {
                            Text("Cancel")
                                .frame(width:80)
                        }
                        .buttonStyle(.glass)
                        .tint(.red)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5) )
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
            }
            // The address information
            GeolocationIAddressView(geolocation: $mapController.currentLocation)
                .padding(EdgeInsets(top: 2, leading: 10, bottom: 0, trailing: 10) )
        }
        .onAppear() {
            // MapAppearanceController.shared.updateAppearance()
        }
        .edgesIgnoringSafeArea(.top)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: { Image(systemName: "arrow.left") } )
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                viewMenu()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(Text("Current Location"), displayMode: .inline)
        .sheet(isPresented: $shareSheetIsPresented) {
            ActivityViewController(location: self.mapController.currentLocation)
        }
    }
    
    // MARK: Submit Button to save a new location
    
    private func submitButton() {
        let geoLocation = self.mapController.currentLocation
        do {
            try self.geolocationRepositoy.addLocation(location: geoLocation)
        } catch {
            print("Error adding Location: \(error)")
        }
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func cancelButton() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func viewMenu() -> some View  {
        Menu() {
            Button {
                shareSheetIsPresented.toggle()
            } label: {
                Label("Share Location", systemImage: "square.and.arrow.up")
            }.buttonStyle(.borderless)
            
            Button {
                // add note
            } label: {
                Label("Add Note", systemImage: "note.text.badge.plus")
            }.buttonStyle(.borderless)
            
            Button {
                // rate
            } label: {
                Label("Rate Location", systemImage: "star")
            }.buttonStyle(.borderless)
            
        } label: {
            Image(systemName: "line.horizontal.3")
                .tint(Color.cocoaBlue)
        }
    }
}

struct MapDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationMapView().preferredColorScheme(.light)
    }
}
