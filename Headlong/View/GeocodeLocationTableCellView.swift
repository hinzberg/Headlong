//  GeocodeLocationTableCellView.swift
//  Headlong
//  Created by Holger Hinzberg on 03.11.21.

import SwiftUI

struct GeocodeLocationTableCellView: View {
    
    public var location : GeocodeLocation
    
    var body: some View {
        VStack {
            HStack {
                Text(location.name).font(.subheadline)
                Spacer()
            }
            HStack {
                Text(location.zipCodeWithCity).font(.subheadline)
                Spacer()
            }
            HStack {
                Text(location.country).font(.subheadline)
                Spacer()
            }
        }
    }
}

struct GeocodeLocationTableCellView_Previews: PreviewProvider {
    static var previews: some View {
        GeocodeLocationTableCellView(location: GeocodeLocation.GetSample())
    }
}
