//  MapAnnotationView.swift
//  Headlong
//  Created by Holger Hinzberg on 01.12.21.
//  Copyright © 2021 Holger Hinzberg. All rights reserved.

import SwiftUI

struct MapAnnotationView: View {

    var body: some View {
        Image(systemName: "flag.circle")
            .resizable()
            .foregroundColor(.cocoaBlue)
            .frame(width: 30, height: 30)
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView()
    }
}
