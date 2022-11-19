//  ShadowPanelModifier.swift
//  Headlong
//  Created by Holger Hinzberg on 19.11.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.

import SwiftUI

public struct ShadowPanelModifier : ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    public var shadowColorUpper : Color = Color(hex: "#FFFFFF")
    
    public var shadowColorLower : Color = Color(hex: "#AEAEC0")
    public var shadowColorLowerDark : Color = Color(hex: "#515130")
        
    public var backgroundColor : Color =  Color(hex: "#F0F0F3")
    public var backgroundColorDark : Color =  Color(hex: "#202020")
    
    public var strokeColor : Color = Color.red
    public var strokeWidth : CGFloat = 1
    
    public func body(content : Content) -> some View {
        content
            .background(
                Rectangle()
                    .cornerRadius(10)
                    .foregroundColor(colorScheme == .dark ? backgroundColorDark : backgroundColor)
                    //.shadow(color: shadowColorUpper, radius: 5, x: -5, y:-5)
                    .shadow(color: colorScheme == .dark ? shadowColorLowerDark : shadowColorLower, radius: 5, x: 5, y:5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke( strokeColor, lineWidth: strokeWidth)
                    )
            )
    }
}

extension View {
    func ShadowPanel(
        strokeColor : Color = Color.white,
        strokeWidth : CGFloat = 1)
    
    -> some View {
        modifier(
            ShadowPanelModifier(
                strokeColor: strokeColor,
                strokeWidth: strokeWidth
            )
        )
    }
}
