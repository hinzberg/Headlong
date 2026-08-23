//  MapDetailView.swift
//  Headlong
//  Created by Holger Hinzberg on 14.10.21.

import SwiftUI
import MapKit

struct AddLocationMapView: View {
    
    @AppStorage("mapType") private var mapType = "Standard"
    @Environment(\.dismiss) private var dismiss
    @ObservedObject  var mapController = CurrentLocationController()
    
    @Environment(\.modelContext) private var modelContext
    @State private var geolocationRepositoy =  GeolocationRepository.shared

    @State private var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
    @State private var hasCenteredOnCurrentLocation = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    // Map
                    Map(position: $cameraPosition)
                    {
                        UserAnnotation()
                    }
                    // Button stack over map
                    VStack {
                        Spacer()
                        Button() {
                            self.submitButton()
                        } label: {
                            Text("Save")
                                .frame(width:80)
                        }
                        .buttonStyle(.glass)
                        .tint(.blue)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    }
                }
                // The address information
                AddressView(geolocation: $mapController.currentLocation)
                    .padding(EdgeInsets(top: 2, leading: 10, bottom: 0, trailing: 10) )
            }
            .onAppear() {
                // MapAppearanceController.shared.updateAppearance()
            }
            .onChange(of: mapController.currentLocation.latitude) { _, _ in
                self.centerCameraOnCurrentLocation()
            }
            .onChange(of: mapController.currentLocation.longitude) { _, _ in
                self.centerCameraOnCurrentLocation()
            }
            .edgesIgnoringSafeArea(.top)
            .toolbar {
                /*
                ToolbarItem(placement: .topBarTrailing) {
                    viewMenu()
                }
                */
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .close) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // MARK: Move the map camera to the users current location
    private func centerCameraOnCurrentLocation()
    {
        guard !self.hasCenteredOnCurrentLocation else { return }
        self.hasCenteredOnCurrentLocation = true
        let location = self.mapController.currentLocation
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
        self.cameraPosition = .region(region)
    }
    
    // MARK: Submit Button to save a new location
    private func submitButton() {
        let geoLocation = self.mapController.currentLocation
        do {
            try self.geolocationRepositoy.add(location: geoLocation)
        } catch {
            print("Error adding Location: \(error)")
        }
        self.dismiss()
    }
}

struct MapDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationMapView().preferredColorScheme(.light)
    }
}

