//
//  MainTabView.swift
//  Shop
//
//  Created by Настя on 15.04.2022.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var tabVM = TabViewModel()
    @StateObject var cartDataModel = CartDataModel()
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0){
            TabView(selection: $tabVM.selection) {
                MenuView()
                    .tag(Tabs.menu)
                HomeView()
                    .tag(Tabs.home)
                CartView()
                    .tag(Tabs.cart)
            }
            CustomTabView()
        }
        .environmentObject(tabVM)
        .environmentObject(cartDataModel)
    }
}

extension MainTabView {
    
    //MARK: - Custom TabView
    @ViewBuilder func CustomTabView() -> some View {
        HStack(spacing: 0){
            Button {
                tabVM.selection = .menu
            } label: {
                Image(Tabs.menu.rawValue)
                    .renderingMode(.template)
                    .foregroundColor(tabVM.selection == .menu ? Color("purple") : .black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .buttonStyle(CustomButtonStyle())
            
            Button {
                tabVM.selection = .home
            } label: {
                Image(tabVM.selection == .home ? "home-2" : Tabs.home.rawValue)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .buttonStyle(CustomButtonStyle())
            
            Button {
                tabVM.selection = .cart
                if tabVM.selection == .cart {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Image(Tabs.cart.rawValue)
                    .renderingMode(.template)
                    .foregroundColor(tabVM.selection == .cart ? Color("purple") : .black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .buttonStyle(CustomButtonStyle())
        }
        .frame(maxWidth: .infinity)
        .frame(height: 77)
        .background(
            Color("tab")
                .edgesIgnoringSafeArea(.bottom)
        )
        .overlay(
            Rectangle()
                .frame(height: 0.2)
                .foregroundColor(Color("border"))
            ,alignment: .top
        )
    }
}
