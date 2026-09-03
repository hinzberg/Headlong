//  StoredLocationMapView.swift
//  Headlong
//  Created by Holger Hinzberg on 01.12.21.
//  Copyright © 2021 Holger Hinzberg. All rights reserved.

import SwiftUI
import MapKit

struct StoredLocationMapView: View {
    
    @ObservedObject  var controller : StoredLocationMapViewController
    @Environment(\.presentationMode) var presentationMode
    @State var shareSheetIsPresented = false
    @State private var hasCenteredOnStoredLocation = false
    
    init(geolocation : Geolocation)
    {
        let geolocationVM = GeolocationViewModel(geolocation: geolocation)
        controller = StoredLocationMapViewController(geolocationVM: geolocationVM)
    }
    
    var body: some View {
        VStack {
            // MapView
            
            ZStack {
                Map(position: $controller.cameraPosition) {
                    UserAnnotation()
                    ForEach(controller.pointsOfInterest) { item in
                        Annotation(item.name, coordinate: item.coordinate) {
                            MapAnnotationView()
                        }
                    }
                }
            }
            
            // ButtonStack
            HStack {
                Button("Navigate To", action: self.controller.NavigateTo)
                    .buttonStyle(.glass)
                
                Button("AR View", action: self.controller.NavigateTo)
                    .buttonStyle(.glass)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .onAppear() {
            // MapAppearanceController.shared.updateAppearance()
            self.centerCameraOnStoredLocation()
        }
        .edgesIgnoringSafeArea(.top)
        /*
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
        .sheet(isPresented: $shareSheetIsPresented, content: {ActivityViewController(location: controller.geocodeLocationVM)})
        */
        
        .toolbar(.hidden, for: .tabBar)
        
        .navigationBarTitle(Text("Selected Location"), displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems( leading: Button(action : {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                })
                .navigationBarItems( trailing: Button(action : {
                    shareSheetIsPresented.toggle()
                }) {
                    Image(systemName: "square.and.arrow.up")
                })
              //  .sheet(isPresented: $shareSheetIsPresented, content: {ActivityViewController(location: controller.geocodeLocationVM)})
    }
    
    // MARK: Move the map camera to the stored location
    private func centerCameraOnStoredLocation()
    {
        guard !self.hasCenteredOnStoredLocation else { return }
        self.hasCenteredOnStoredLocation = true
        guard let location = self.controller.geolocationVM.location?.coordinate else { return }
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
        self.controller.cameraPosition = .region(region)
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
                .tint(Color.veryPeri)
        }
    }
}

struct ShowLocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        StoredLocationMapView(geolocation:  Geolocation.GetSample())
    }
}
