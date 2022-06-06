//
//  CartItemView.swift
//  Shop
//
//  Created by Настя on 18.04.2022.
//

import SwiftUI

struct CartItemView: View {
    
    let item: CartItem
    let cartDataModel: CartDataModel
    @State var price: Int = 0
    
    var body: some View {
        VStack(spacing: 14) {
            HStack(alignment: .top, spacing: 24) {
                if let image = item.item.images.first {
                    Image("\(image)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 125)
                }
                VStack(alignment: .leading, spacing: 6) {
                    Text(item.item.name)
                        .foregroundColor(Color.black)
                        .font(.custom(montserrat, size: 15))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                    Text(item.item.description)
                        .foregroundColor(Color("bar"))
                        .font(.custom(montserrat, size: 10))
                        .multilineTextAlignment(.leading)
                        .lineLimit(6)
                }
            }
            HStack(spacing: 0) {
                Text("\(price) Р")
                    .foregroundColor(Color.black)
                    .font(.custom(montserrat, size: 15))
                    .fontWeight(.bold)
                Spacer()
                HStack(spacing: 12) {
                    Button {
                        withAnimation(.interactiveSpring()) {
                            cartDataModel.minusItemInCart(cartItem: item)
                            price = item.totalPrice
                        }
                    } label: {
                        Circle()
                            .frame(width: 26, height: 26)
                            .foregroundColor(Color.white)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 0)
                            .overlay(
                                Text("-")
                                    .foregroundColor(Color("bar"))
                                    .font(.custom(montserrat, size: 25))
                                    .offset(y: -2)
                            )
                    }
                    .buttonStyle(.plain)
                    Text("\(item.count)")
                        .foregroundColor(Color.black)
                        .font(.custom(montserrat, size: 15))
                        .fontWeight(.medium)
                        .frame(width: 30)
                    Button {
                        cartDataModel.plusItemInCart(cartItem: item)
                        price = item.totalPrice
                    } label: {
                        Circle()
                            .frame(width: 26, height: 26)
                            .foregroundColor(Color.white)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 0)
                            .overlay(
                                Text("+")
                                    .foregroundColor(Color("bar"))
                                    .font(.custom(montserrat, size: 25))
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.horizontal, 28)
        .onAppear {
            self.price = item.totalPrice
        }
    }
}
