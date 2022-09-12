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
    
    init(geocodeLocationVM : GeocodeLocationViewModel)
    {
        controller = StoredLocationMapViewController(geocodeLocationVM: geocodeLocationVM)
    }
    
    var body: some View {
        VStack {
            // MapView
            Map(coordinateRegion: $controller.region, showsUserLocation: true, annotationItems: controller.pointsOfInterest ){ item in
                MapAnnotation(coordinate: item.coordinate) { MapAnnotationView() }
            }
            // LocationView
            GeocodeLocationView(locationVM: $controller.geocodeLocationVM)
                .padding(EdgeInsets(top: 2, leading: 10, bottom: 0, trailing: 10) )
            
            // ButtonStack
            HStack {
                Button("Navigate To", action: self.controller.NavigateTo)
                    .buttonStyle(SubmitButtonStyle())
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 2) )
                
                Button("AR View", action: self.controller.NavigateTo)
                    .buttonStyle(SubmitButtonStyle())
                    .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 10) )
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
        .onAppear() {
            // MapAppearanceController.shared.updateAppearance()
        }
        .edgesIgnoringSafeArea(.top)
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
        .sheet(isPresented: $shareSheetIsPresented, content: {ActivityViewController(location: controller.geocodeLocationVM)})
    }
}

struct ShowLocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        StoredLocationMapView(geocodeLocationVM:  GeocodeLocationViewModel.GetSample())
    }
}
