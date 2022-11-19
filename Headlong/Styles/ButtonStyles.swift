//  ButtonStyles.swift
//  Headlong
//  Created by Holger Hinzberg on 30.10.21.

import SwiftUI

struct ShadowButtonStyle: ButtonStyle {
    
    public var shadowColorUpper : Color = Color(hex: "#FFFFFF")
    public var shadowColorLower : Color = Color(hex: "#AEAEC0")
    public var backgroundColor = Color(hex: "#F0F0F3")
    public var strokeColor : Color = Color.red
    public var strokeWidth : CGFloat = 1
        
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5) )
            .font(.title3)
        
            .foregroundColor(backgroundColor)
            //.shadow(color: shadowColorUpper, radius: 5, x: -5, y:-5)
            .shadow(color: shadowColorLower, radius: 5, x: 5, y:5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke( strokeColor, lineWidth: strokeWidth)
            )
        
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct SubmitButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5) )
            .font(.title3)
            .foregroundColor(.white)
            .background(Color.cocoaBlue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct CancelButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5) )
            .font(.title3)
            .foregroundColor(.white)
            .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
