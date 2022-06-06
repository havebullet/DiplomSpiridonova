//
//  CustomButtonStyle.swift
//  Shop
//
//  Created by Настя on 18.04.2022.
//

import Foundation
import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.default, value: configuration.isPressed)
    }
}
