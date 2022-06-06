//
//  DetailView.swift
//  Shop
//
//  Created by Настя on 15.04.2022.
//

import SwiftUI

struct DetailView: View {
    
    let item: Item
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cartDataModel: CartDataModel
    @EnvironmentObject var tabVM: TabViewModel
    @State var selection: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ImagesSlider()
                    DetailInformation()
                    CustomButton(title: cartDataModel.checkingItemInCart(item: item) ? "ТОВАР УЖЕ В КОРЗИНЕ" : "ДОБАВИТЬ В КОРЗИНУ", action: {
                        if cartDataModel.checkingItemInCart(item: item) {
                            tabVM.selection = .cart
                        } else {
                            cartDataModel.addItem(item: item)
                        }
                    })
                    .padding(.horizontal, 52)
                    .padding(.top, 25)
                }
                .padding(.bottom, 24)
            }
            .background(Color.white)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onReceive(tabVM.$selection) { out in
            if tabVM.selection == .home {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

extension DetailView {
    
    //MARK: - Navigation Bar
    @ViewBuilder func NavigationBar() -> some View {
        NavBarView {
            Text("ТОВАР")
                .foregroundColor(Color.white)
                .font(.custom(montserrat, size: 17))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
                .overlay(
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                    })
                    .padding(.leading)
                    ,alignment: .leading
                )
        }
    }
    
    //MARK: - Detail Information
    @ViewBuilder func ImagesSlider() -> some View {
        VStack(spacing: 24) {
            TabView(selection: $selection) {
                ForEach(item.images, id: \.self) { image in
                    GeometryReader { reader in
                        let size = reader.size
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: size.width, height: size.height)
                    }
                    .frame(width: 215, height: 260)
                    .tag(image)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 215)
            .padding(.top, 40)
            HStack(spacing: 10) {
                if item.images.count > 1 {
                    ForEach(item.images, id: \.self) { circle in
                        Circle()
                            .frame(width: 6, height: 6)
                            .foregroundColor(selection == circle ? Color("bar") : Color(#colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)))
                    }
                }
            }
            .padding(.bottom, 24)
        }
    }
    
    
    //MARK: - Detail Information
    @ViewBuilder func DetailInformation() -> some View {
        VStack(spacing: 24) {
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color(#colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)))
            VStack(spacing: 36) {
                VStack(spacing: 10) {
                    Text(item.name)
                        .foregroundColor(Color.black)
                        .font(.custom(montserrat, size: 15))
                        .fontWeight(.medium)
                    Text(item.description)
                        .foregroundColor(Color("bar"))
                        .font(.custom(montserrat, size: 12))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 40)
                Text("\(item.price) Р / 1 шт")
                    .foregroundColor(Color.black)
                    .font(.custom(montserrat, size: 15))
                    .fontWeight(.bold)
            }
        }
    }
}
