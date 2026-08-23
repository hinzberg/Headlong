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
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    // Map
                    Map(position: $cameraPosition)
                    {
                        // You can add MapAnnotation, MapMarker, etc. here if needed (leave empty for now)
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
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
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

