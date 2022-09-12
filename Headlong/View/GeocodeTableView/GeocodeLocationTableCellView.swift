//  GeocodeLocationTableCellView.swift
//  Headlong
//  Created by Holger Hinzberg on 03.11.21.

import SwiftUI
import Hinzberg_SwiftUI

struct GeocodeLocationTableCellView: View {
    
    public var locationVM : GeocodeLocationViewModel
    
    var body: some View {
        VStack {
            
            // Date
            HStack {
                Text(locationVM.dateFormatted)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
            }
            
            // Street
            HStack {
                Text(locationVM.name)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                Spacer()
            }
            
            // Zip, City, Country
            HStack {
                Text(locationVM.zipCodeWithCityAndCountry)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                Spacer()
            }
            HorizontalColorDivider(height: 3, color: Color.cocoaBlue)
        }
    }
}

struct GeocodeLocationTableCellView_Previews: PreviewProvider {
    static var previews: some View {
        GeocodeLocationTableCellView(locationVM: GeocodeLocationViewModel.GetSample())
    }
}
