//  GeolocationTableCellView.swift
//  Headlong
//  Created by Holger Hinzberg on 19.07.26.

import SwiftUI
import Hinzberg_SwiftUI

struct GeolocationTableCellView: View {
    
    enum PanelCornerStyle {
        case allCorners
        case topCorners
        case bottomCorners
        case noCorners
    }
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var locationVM : GeolocationViewModel
    private var geolocation : Geolocation
    private var cornerStyle : PanelCornerStyle
    
    private let strokeWidth : CGFloat = 1
    private let cornerRadius : CGFloat = 10
    
    private var backgroundColor : Color {
        return colorScheme == .dark ? Color.anthracite  : Color.whiteSand
    }
    
    private var strokeColor : Color {
        return colorScheme == .dark ? Color.veryPeri : Color.veryPeri
    }
    
    private var panelShape : UnevenRoundedRectangle {
        switch self.cornerStyle {
        case .allCorners:
            return UnevenRoundedRectangle(topLeadingRadius: self.cornerRadius,
                                          bottomLeadingRadius: self.cornerRadius,
                                          bottomTrailingRadius: self.cornerRadius,
                                          topTrailingRadius: self.cornerRadius)
        case .topCorners:
            return UnevenRoundedRectangle(topLeadingRadius: self.cornerRadius,
                                          bottomLeadingRadius: 0,
                                          bottomTrailingRadius: 0,
                                          topTrailingRadius: self.cornerRadius)
        case .bottomCorners:
            return UnevenRoundedRectangle(topLeadingRadius: 0,
                                          bottomLeadingRadius: self.cornerRadius,
                                          bottomTrailingRadius: self.cornerRadius,
                                          topTrailingRadius: 0)
        case .noCorners:
            return UnevenRoundedRectangle(topLeadingRadius: 0,
                                          bottomLeadingRadius: 0,
                                          bottomTrailingRadius: 0,
                                          topTrailingRadius: 0)
        }
    }
    
    public init(geolocation: Geolocation, cornerStyle: PanelCornerStyle = .allCorners)
    {
        self.locationVM = GeolocationViewModel(geolocation: geolocation)
        self.geolocation = geolocation
        self.cornerStyle = cornerStyle
    }
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(locationVM.time)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    if self.geolocation.isFavorite {
                        Image(systemName: "heart.fill")
                            .font(.subheadline)
                            .foregroundColor(.paradisePink)
                    }
                }
                HStack {
                    Text(locationVM.name)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                }
                HStack {
                    Text(locationVM.zipCodeWithCityAndCountry)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                }
            }
            Image(systemName: "chevron.right")
                .foregroundColor(.veryPeri)
        }
        .padding()
        .background(
            self.panelShape
                .foregroundColor(self.backgroundColor)
                .overlay(
                    self.panelShape
                        .stroke(self.strokeColor, lineWidth: self.strokeWidth)
                )
        )
    }
}

struct GeolocationTableCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            GeolocationTableCellView(geolocation: Geolocation.GetSample(), cornerStyle: .topCorners)
            GeolocationTableCellView(geolocation: Geolocation.GetSample(), cornerStyle: .noCorners)
            GeolocationTableCellView(geolocation: Geolocation.GetSample(), cornerStyle: .bottomCorners)
        }
        .padding()
    }
}
