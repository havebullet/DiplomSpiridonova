//
//  ItemCardView.swift
//  Shop
//
//  Created by Настя on 15.04.2022.
//

import SwiftUI

struct ItemCardView: View {
    
    let item: Item
    let cartDataModel: CartDataModel
    @State var isItemInCart: Bool?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4.67) {
            if let image = item.images.first {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 170)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.custom(montserrat, size: 12))
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(height: 34)
                HStack(spacing: 0) {
                    Text("\(item.price) Р/ 1 шт.")
                        .font(.custom(montserrat, size: 10))
                        .fontWeight(.semibold)
                    Spacer()
                    
                    if isItemInCart == false {
                        Button {
                            withAnimation {
                                cartDataModel.addItem(item: item)
                                self.isItemInCart = cartDataModel.checkingItemInCart(item: item)
                            }
                        } label: {
                            Image("plus")
                        }
                    }
                }
                .frame(height: 29)
            }
            .foregroundColor(Color.black)
        }
        .onAppear {
            self.isItemInCart = cartDataModel.checkingItemInCart(item: item)
        }
    }
}
