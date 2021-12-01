//  GeocodeLocationTableCellView.swift
//  Headlong
//  Created by Holger Hinzberg on 03.11.21.

import SwiftUI
import Hinzberg_Swift_SwiftUI

struct GeocodeLocationTableCellView: View {
    
    public var location : GeocodeLocation
    
    var body: some View {
        VStack {
            HStack {
                Text(location.dateFormatted)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
            }
            
            HStack {
                Text(location.name).font(.subheadline)
                Spacer()
            }
            HStack {
                Text(location.zipCodeWithCityAndCountry).font(.subheadline)
                Spacer()
            }
            HorizontalColorDivider(height: 3, color: Color.cocoaBlue)
        }
    }
}

struct GeocodeLocationTableCellView_Previews: PreviewProvider {
    static var previews: some View {
        GeocodeLocationTableCellView(location: GeocodeLocation.GetSample())
    }
}
