//
//  ProfileButtonStyle.swift
//  Shop
//
//  Created by Настя on 18.04.2022.
//

import SwiftUI

struct ProfileButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom(montserrat, size: 15))
            .foregroundColor(Color.black)
            .frame(maxWidth: .infinity)
            .frame(height: 35)
            .background(Color.white)
            .cornerRadius(5)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.default, value: configuration.isPressed)
            .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 0.5)
                .foregroundColor(Color.black)
            )
    }
}

