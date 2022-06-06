//
//  CustomButton.swift
//  Shop
//
//  Created by Настя on 15.04.2022.
//

import SwiftUI

struct CustomButton: View {
    
    let title: String
    var foregroundColor: Color = Color.white
    var backgroundColor: Color = Color("bar")
    let action: () -> ()

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.custom(montserrat, size: 15))
                .fontWeight(.bold)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(backgroundColor)
                .cornerRadius(5)
        }
        .buttonStyle(CustomButtonStyle())
    }
}
