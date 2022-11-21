//  ShadowButtonStyles.swift
//  Headlong
//  Created by Holger Hinzberg on 21.11.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.

import SwiftUI

struct ShadowButtonStyle: ButtonStyle
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
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5) )
            .font(.title3)
            .foregroundColor(Color.primary)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke( strokeColor, lineWidth: strokeWidth)
            )
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5) )
            .font(.title3)
            .foregroundColor(backgroundColor)
            .shadow(color: shadowColor, radius: 3, x: 3, y:3)
    }
}


struct SubmitShadowButtonStyle: ButtonStyle
{
    @Environment(\.colorScheme) var colorScheme
    
    private var strokeWidth : CGFloat = 3
    
    private var shadowColor : Color {
        return colorScheme == .dark ? Color(hex: "#808080") : Color(hex: "#AEAEC0")
    }
    
    private var backgroundColor : Color {
        return colorScheme == .dark ? Color(hex: "#303030") : Color(hex: "#F0F0F3")
    }
    
    private var submitColor : Color {
        return colorScheme == .dark ? Color(UIColor.systemBlue) : Color(UIColor.systemBlue)
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5) )
            .font(.title3)
            .foregroundColor(submitColor)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke( submitColor, lineWidth: strokeWidth)
            )
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5) )
            .font(.title3)
            .foregroundColor(backgroundColor)
            .shadow(color: shadowColor, radius: 3, x: 3, y:3)
    }
}

struct CancelShadowButtonStyle: ButtonStyle
{
    @Environment(\.colorScheme) var colorScheme
    
    private var strokeWidth : CGFloat = 3
    
    private var shadowColor : Color {
        return colorScheme == .dark ? Color(hex: "#505050") : Color(hex: "#AEAEC0")
    }
    
    private var backgroundColor : Color {
        return colorScheme == .dark ? Color(hex: "#303030") : Color(hex: "#F0F0F3")
    }
    
    private var submitColor : Color {
        return colorScheme == .dark ? Color(UIColor.systemRed) : Color(UIColor.systemRed)
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5) )
            .font(.title3)
            .foregroundColor(submitColor)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke( submitColor, lineWidth: strokeWidth)
            )
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5) )
            .font(.title3)
            .foregroundColor(backgroundColor)
            .shadow(color: shadowColor, radius: 3, x: 3, y:3)
    }
}
