//  ButtonStyles.swift
//  Headlong
//  Created by Holger Hinzberg on 30.10.21.

import SwiftUI

struct SubmitButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5) )
            .font(.title3)
            .foregroundColor(.white)
            .background(Color.cocoaBlue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct CancelButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5) )
            .font(.title3)
            .foregroundColor(.white)
            .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
