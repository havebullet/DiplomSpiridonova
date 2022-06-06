//
//  HistoryItemView.swift
//  Shop
//
//  Created by Student on 20.04.2022.
//

import SwiftUI

struct HistoryItemView: View {
    let order: Order
    var body: some View {
        VStack(spacing: 0) {
            Text(order.date)
                .foregroundColor(Color.black)
                .font(.custom(montserrat, size: 15))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 5) {
                ForEach(order.items, id: \.id) { item in
                    CartItem(item: item)
                }
            }
            .padding(.top, 12)
            .padding(.bottom, 22)
            BottomView()
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 0.5)
                .foregroundColor(Color.black)
        )
    }
}

extension HistoryItemView {
    
    //MARK: - Cart Item
    @ViewBuilder func CartItem(item: CartItem) -> some View {
        HStack(spacing: 0) {
            Text("\(item.count)x ")
                .foregroundColor(Color.black)
                .font(.custom(montserrat, size: 10))
                .fontWeight(.semibold)
            Text(item.item.name)
                .foregroundColor(Color.black)
                .font(.custom(montserrat, size: 10))
                .fontWeight(.regular)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //MARK: - Bottom View
    @ViewBuilder func BottomView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 0) {
                Text("Сумма заказа ")
                    .foregroundColor(Color(#colorLiteral(red: 0.8666666667, green: 0.3725490196, blue: 0.4666666667, alpha: 1)))
                    .font(.custom(montserrat, size: 12))
                    .fontWeight(.semibold)
                Text("\(order.totalPrice)")
                    .foregroundColor(Color("bar"))
                    .font(.custom(montserrat, size: 12))
                    .fontWeight(.semibold)
            }
            HStack(spacing: 0) {
                Text("Статус заказа ")
                    .foregroundColor(Color(#colorLiteral(red: 0.8666666667, green: 0.3725490196, blue: 0.4666666667, alpha: 1)))
                    .font(.custom(montserrat, size: 12))
                    .fontWeight(.semibold)
                Text(order.status.rawValue)
                    .foregroundColor(Color("bar"))
                    .font(.custom(montserrat, size: 12))
                    .fontWeight(.semibold)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}
