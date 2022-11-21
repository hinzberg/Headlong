//  MapDetailView.swift
//  Headlong
//  Created by Holger Hinzberg on 14.10.21.

import SwiftUI
import MapKit

struct AddLocationMapView: View {
    
    @AppStorage("mapType") private var mapType = "Standard"
    @EnvironmentObject  var geocodeRepository : GeocodeLocationRepository
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject  var controller = AddLocationMapViewController()
    
    @State var shareSheetIsPresented = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        VStack {
            // Map
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
            
            // LocationView
            GeocodeLocationView(locationVM: $controller.geocodeLocationVM)
                .padding(EdgeInsets(top: 2, leading: 10, bottom: 0, trailing: 10) )
            
            // ButtonStack
            HStack {
                Button("Save", action: self.submitButton )
                    .buttonStyle(SubmitShadowButtonStyle())
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0) )
                
                Button("Cancel", action: self.cancelButton )
                    .buttonStyle(CancelShadowButtonStyle())
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5) )
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
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
        .sheet(isPresented: $shareSheetIsPresented) {ActivityViewController(location: self.controller.geocodeLocationVM) }
    }
    
    private func submitButton() {
        self.geocodeRepository.add(locationVM: self.controller.geocodeLocationVM)
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
