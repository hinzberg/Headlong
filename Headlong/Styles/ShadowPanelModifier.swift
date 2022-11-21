//  ShadowPanelModifier.swift
//  Headlong
//  Created by Holger Hinzberg on 19.11.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.

import SwiftUI

public struct ShadowPanelModifier : ViewModifier
{
    @Environment(\.colorScheme) var colorScheme
    
    private var strokeWidth : CGFloat = 1
    
    private var shadowColor : Color {
        return colorScheme == .dark ? Color(hex: "#000000") : Color(hex: "#AEAEC0")
    }
    
    private var backgroundColor : Color {
        return colorScheme == .dark ? Color(hex: "#404040") : Color(hex: "#F0F0F3")
    }
    
    private var strokeColor : Color {
        return colorScheme == .dark ? Color.black : Color.white
    }
           
    public func body(content : Content) -> some View {
        content
            .background(
                Rectangle()
                    .cornerRadius(10)
                    .foregroundColor( backgroundColor)
                    .shadow(color: shadowColor, radius: 3, x: 3, y:3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke( strokeColor, lineWidth: strokeWidth)
                    )
            )
    }
}

extension View {
    func ShadowPanel()-> some View {
        modifier(
            ShadowPanelModifier()
        )
    }
}
