//  GeocodeLocationTableCellView.swift
//  Headlong
//  Created by Holger Hinzberg on 03.11.21.

import SwiftUI
import Hinzberg_Swift_SwiftUI

struct GeocodeLocationTableCellView: View {
    
    public var locationVM : GeocodeLocationViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(locationVM.dateFormatted)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
            }
            
            HStack {
                Text(locationVM.name).font(.subheadline)
                Spacer()
            }
            HStack {
                Text(locationVM.zipCodeWithCityAndCountry).font(.subheadline)
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
