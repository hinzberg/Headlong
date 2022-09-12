//
//  GeocodeTableViewSectionHeader.swift
//  Headlong
//
//  Created by Holger Hinzberg on 12.09.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.
//

import SwiftUI

struct GeocodeTableViewSectionHeader: View
{
    var headlineText : String
    let backColor = Color(UIColor.systemBackground)
    let foreColor = Color.cocoaBlue
    
    var body: some View {
            HStack {
                Text(headlineText)
                    .font(.title3.bold())
                    .foregroundColor(foreColor)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 0))
                Spacer()
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .background(backColor)
    }
}

struct GeocodeTableViewSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        GeocodeTableViewSectionHeader(headlineText: "Hello World")
    }
}
