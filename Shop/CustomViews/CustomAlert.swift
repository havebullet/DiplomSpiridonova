//
//  CustomAlert.swift
//  Shop
//
//  Created by Настя on 19.04.2022.
//

import SwiftUI

struct CustomAlert: View {
    
    let title: String
    let message: String
    let buttonTitle: String
    let action: () -> ()
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.12)
                .ignoresSafeArea()
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 20){
                Text(title)
                    .font(.custom(montserrat, size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                Text(message)
                    .font(.custom(montserrat, size: 15))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(7)
            }
            CustomButton(title: buttonTitle) {
                action()
            }
            .padding(.horizontal, 30)
            
        }
        .padding(.horizontal, 30)
        .padding(.top, 20)
        .padding(.bottom)
        .background(Color(#colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 24)
        }
    }
}


