//
//  MapDetailView.swift
//  Headlong
//
//  Created by Holger Hinzberg on 14.10.21.
//

import SwiftUI
import MapKit

struct MapDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject  var locationController = LocationController()
        
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View {
        VStack {
            // Map
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
            //.frame(width: 400, height: 300)
            
            // LocationView
            GeocodeLocationView(geoData: $locationController.geocodeLocation)
                .padding(EdgeInsets(top: 2, leading: 10, bottom: 0, trailing: 10) )
            
            // ButtonStack
            HStack {
                Button("Save", action: { self.presentationMode.wrappedValue.dismiss() })
                    .buttonStyle(SubmitButtonStyle())
                    .padding(EdgeInsets(top: 2, leading: 10, bottom: 5, trailing: 2) )
                
                Button("Cancel", action: { self.presentationMode.wrappedValue.dismiss() })
                    .buttonStyle(CancelButtonStyle())
                    .padding(EdgeInsets(top: 2, leading: 2, bottom: 5, trailing: 10) )
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitle(Text("Current Location"), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems( leading: Button(action : {
            self.presentationMode.wrappedValue.dismiss()
        }) {
                Image(systemName: "arrow.left")
        })
    }
}


struct MapDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MapDetailView().preferredColorScheme(.light)
    }
}
