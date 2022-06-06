//
//  PinkButtonStyle.swift
//  Shop
//
//  Created by Настя on 19.04.2022.
//

import SwiftUI

struct PinkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom(montserrat, size: 15))
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: 35)
            .background(Color(#colorLiteral(red: 0.8666666667, green: 0.3725490196, blue: 0.4666666667, alpha: 1)))
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.default, value: configuration.isPressed)
    }
}
