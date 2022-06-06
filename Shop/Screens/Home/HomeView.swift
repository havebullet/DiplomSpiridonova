//
//  HomeView.swift
//  Shop
//
//  Created by Настя on 15.04.2022.
//

import SwiftUI
import Introspect

struct HomeView: View {
    
    @EnvironmentObject var cartDataModel: CartDataModel
    @EnvironmentObject var tabVM: TabViewModel
    @State var showProfile: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                NavigationBar()
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 0) {
                        
                        ZStack{
                            if tabVM.searchText.isEmpty {
                                VStack(spacing: 0) {
                                    PromotionView()
                                    PopularItemsList()
                                    
                                        .padding(.top, 37)
                                        .padding(.bottom, 24)
                                }
                            } else {
                                SearchItemsList()
                                    .padding(.top, 37)
                                    .padding(.bottom, 24)
                            }
                        }
                        
                    }
                }
                .background(Color.white)
            }
            .navigationBarHidden(true)
        }
    }
}

extension HomeView {
    
    //MARK: - Navigation Bar
    @ViewBuilder func NavigationBar() -> some View {
        NavBarView {
            HStack(spacing: 0) {
                SearchView(text: $tabVM.searchText, placeholder: "Искать")
                Spacer()
                
                Button {
                    showProfile = true
                } label: {
                    Image("user")
                }
                .overlay(
                    NavigationLink(isActive: $showProfile, destination: {
                        ProfileView()
                    }, label: {
                        EmptyView()
                    })
                )
            }
            .padding(.leading, 27)
            .padding(.trailing, 37.4)
        }
    }
    
    //MARK: - Promotion View
    @ViewBuilder func PromotionView() -> some View {
        GeometryReader { reader in
            let size = reader.size
            
            Image("example")
                .resizable()
                .frame(width: size.width, height: size.height)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 270)
        .overlay(
            Button(action: {
                
            }, label: {
                HStack(spacing: 16){
                    Text("Перейти к акциям")
                        .foregroundColor(Color.white)
                        .font(.custom(montserrat, size: 12))
                        .fontWeight(.medium)
                    Image("arrow")
                }
                .padding(.leading, 9)
                .padding(.trailing, 12)
                .frame(height: 33)
                .background(Color("bar"))
            })
                .padding(.bottom, 8)
                .padding(.leading, 20)
            ,alignment: .bottomLeading
        )
    }
    //MARK: - Promotion View
    @ViewBuilder func PopularItemsList() -> some View {
        VStack(spacing: 25) {
            Text("Популярные товары".uppercased())
                .foregroundColor(Color.black)
                .font(.custom(montserrat, size: 15))
                .fontWeight(.medium)
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 40),GridItem(.flexible())], alignment: .center, spacing: 45) {
                ForEach(items.prefix(4), id: \.id) { item in
                    NavigationLink {
                        DetailView(item: item)
                    } label: {
                        ItemCardView(item: item, cartDataModel: cartDataModel)
                    }
                    .buttonStyle(CustomButtonStyle())
                }
            }
            .padding(.horizontal, 28)
        }
    }
    
    //MARK: - Promotion View
    @ViewBuilder func SearchItemsList() -> some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 40),GridItem(.flexible())], alignment: .center, spacing: 45) {
            ForEach(getSearchItems(), id: \.self) { item in
                NavigationLink {
                    DetailView(item: item)
                } label: {
                    ItemCardView(item: item, cartDataModel: cartDataModel)
                }
                .buttonStyle(CustomButtonStyle())
            }
        }
        .padding(.horizontal, 28)
    }
    
    func getSearchItems() -> [Item] {
        let items = items.filter({ $0.brand.uppercased().contains(tabVM.searchText.uppercased())  || $0.category.uppercased().contains(tabVM.searchText.uppercased()) || $0.name.uppercased().contains(tabVM.searchText.uppercased()) })
        return items
    }
}
