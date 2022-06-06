//
//  SearchView.swift
//  Shop
//
//  Created by Настя on 15.04.2022.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        HStack(spacing: 7.88){
            Image("search")
            ZStack{
                if text.isEmpty {
                    Text(placeholder)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                TextField("", text: $text)
            }
            .foregroundColor(Color.white)
            .font(.custom(montserrat, size: 12))
            if !text.isEmpty {
                Button {
                    withAnimation {
                        text = ""
                    }
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.white.opacity(0.75))
                        .font(.system(size: 14))
                }
            }

        }
        .padding(.horizontal, 12.52)
        .frame(width: 204, height: 32)
        .background(Color(#colorLiteral(red: 0.3882352941, green: 0.3882352941, blue: 0.3882352941, alpha: 1)))
        .cornerRadius(49)
    }
}



