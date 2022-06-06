//
//  CartView.swift
//  Shop
//
//  Created by Настя on 15.04.2022.
//

import SwiftUI

enum CartState: CaseIterable {
    case emptyCart
    case notEmptyCart
}

struct CartView: View {
    
    @EnvironmentObject var tabVM: TabViewModel
    @EnvironmentObject var cartDataModel: CartDataModel
    @State var navBarTitle: String = "Корзина"
    @State var showOrderView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                NavigationBar()
                
                if cartDataModel.items.isEmpty {
                    EmptyCart()
                } else {
                    CartItemsList()
                }
            }
            .background(Color.white)
            .navigationBarHidden(true)
        }
    }
}

extension CartView {
    
    //MARK: - Navigation Bar
    @ViewBuilder func NavigationBar() -> some View {
        NavBarView {
            Text(navBarTitle.uppercased())
                .foregroundColor(Color.white)
                .font(.custom(montserrat, size: 17))
                .fontWeight(.bold)
        }
    }
    
    //MARK: - Empty Cart
    @ViewBuilder func EmptyCart() -> some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 26) {
                Image("bigCart")
                VStack(spacing: 8) {
                    Text("УПС")
                        .foregroundColor(Color.black)
                        .font(.custom(montserrat, size: 20))
                        .fontWeight(.bold)
                    Text("Твоя корзина пуста")
                        .foregroundColor(Color("bar"))
                        .font(.custom(montserrat, size: 20))
                        .fontWeight(.medium)
                }
            }
            Spacer()
            CustomButton(title: "ПЕРЕЙТИ В КАТАЛОГ") {
                tabVM.selection = .home
            }
            .padding(.horizontal, 52)
            .padding(.bottom, 52)
        }
    }
    
    //MARK: - Cart Items List
    @ViewBuilder func CartItemsList() -> some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 0) {
                VStack(spacing: 24) {
                    ForEach(cartDataModel.items, id: \.id) { item in
                        CartItemView(item: item, cartDataModel: cartDataModel)
                    }
                }
                .padding(.top, 24)
                .padding(.bottom, 38)
                VStack(spacing: 18) {
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color(#colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)))
                    HStack(spacing: 0) {
                        Text("\(cartDataModel.totalCount) товар на сумму")
                            .foregroundColor(Color("bar"))
                            .font(.custom(montserrat, size: 12))
                        Spacer()
                        Text("\(cartDataModel.totalPrice) Р")
                            .foregroundColor(.black)
                            .font(.custom(montserrat, size: 15))
                            .fontWeight(.medium)
                    }
                    .padding(.horizontal, 28)
                }
                
                CustomButton(title: "ОФОРМИТЬ ЗАКАЗ") {
                    showOrderView = true
                }
                .padding(.horizontal, 52)
                .padding(.bottom, 52)
                .overlay(
                    NavigationLink(isActive: $showOrderView, destination: {
                        MyContactView()
                    }, label: {
                        EmptyView()
                    })
                )
                .padding(.top, 34)
            }
            .padding(.bottom, 44)
        }
        
    }
    
}
