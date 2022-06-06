//
//  InfoItemView.swift
//  Shop
//
//  Created by Настя on 18.04.2022.
//

import SwiftUI

struct InfoItemView: View {
    
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.custom(montserrat, size: 12))
                .foregroundColor(Color.black.opacity(0.8))
                .frame(maxWidth: .infinity, alignment: .leading)
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color(#colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)))
        }
    }
    
}
