//
//  CustomTextField.swift
//  Shop
//
//  Created by Настя on 15.04.2022.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        VStack(spacing: 6) {
            ZStack{
                if text.isEmpty {
                    Text(placeholder)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                TextField("", text: $text)
            }
            .font(.custom(montserrat, size: 15))
            .foregroundColor(Color(#colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 1)))
            
            Rectangle()
                .frame(height: 0.3)
                .foregroundColor(Color(#colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 1)))
        }
    }
}

