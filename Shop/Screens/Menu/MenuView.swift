//
//  MenuView.swift
//  Shop
//
//  Created by Настя on 15.04.2022.
//

import SwiftUI

enum Segments: String, CaseIterable {
    case categories = "КАТЕГОРИИ"
    case brands = "БРЕНДЫ"
}

struct MenuView: View {
    
    @EnvironmentObject var tabVM: TabViewModel
    @State var categories: [String] = []
    @State var brands: [String] = []
    @State var selection: Segments = .categories
    @Namespace var animation
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                NavigationBar()
                SegmentPicker()
                    .zIndex(1)
                TabView(selection: $selection) {
                    MenuItems(items: categories)
                        .tag(Segments.categories)
                    MenuItems(items: brands)
                        .tag(Segments.brands)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .background(Color.white)
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            getCategories()
            getBrands()
        }
    }
    
    //MARK: - Methods
    
    func getCategories() {
        var categories: Set<String> = Set<String>()
        for item in items {
            categories.insert(item.category)
        }
        self.categories = Array(categories).sorted(by: {$0 < $1})
    }
    
    func getBrands() {
        var brands: Set<String> = Set<String>()
        for item in items {
            brands.insert(item.brand)
        }
        self.brands = Array(brands).sorted(by: {$0 < $1})
    }
}

extension MenuView {
    
    //MARK: - Navigation Bar
    @ViewBuilder func NavigationBar() -> some View {
        NavBarView {
            Text("Меню".uppercased())
                .foregroundColor(Color.white)
                .font(.custom(montserrat, size: 17))
                .fontWeight(.bold)
        }
    }
    
    //MARK: - Segment Picker
    @ViewBuilder func SegmentPicker() -> some View {
        HStack(spacing: 0) {
            ForEach(Segments.allCases, id: \.self) { segment in
                Button {
                    withAnimation {
                        selection = segment
                    }
                } label: {
                    Text(segment.rawValue)
                        .foregroundColor(Color.black)
                        .font(.custom(montserrat, size: 17))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                }
                .overlay(
                    ZStack {
                        if selection == segment {
                            Rectangle()
                                .frame(height: 1.5)
                                .foregroundColor(Color("bar"))
                                .matchedGeometryEffect(id: "Segment", in: animation)
                        }
                    }
                    ,alignment: .bottom
                )
            }
        }
        .frame(height: 48)
        .animation(.default, value: selection)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 1)
        .overlay(
            Rectangle()
                .frame(width: 0.8, height: 26)
                .foregroundColor(Color(#colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)))
        )
    }
    
    //MARK: - Menu Items
    @ViewBuilder func MenuItems(items: [String]) -> some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 0){
                ForEach(items, id: \.self) { item in
                    VStack(alignment: .leading, spacing: 0) {
                        if item != items.first {
                            Rectangle()
                                .frame(height: 0.5)
                                .foregroundColor(Color(#colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)))
                        }
                        Button {
                            tabVM.searchText = item.uppercased()
                            withAnimation {
                                tabVM.selection = .home
                            }
                        } label: {
                            Text(item.uppercased())
                                .foregroundColor(Color.black)
                                .font(.custom(montserrat, size: 17))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 50)
                        }
                        Rectangle()
                            .frame(height: 0.5)
                            .foregroundColor(Color(#colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)))
                    }
                }
            }
            .padding(.horizontal, 27)
            .padding(.top, 24)
        }
    }
    
}

