//
//  HistoryView.swift
//  Shop
//
//  Created by Student on 20.04.2022.
//

import SwiftUI
import Introspect

enum HistroyState: String, CaseIterable {
    case emptyHistory
    case notEmptyHistory
}

struct HistoryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var tabVM: TabViewModel
    @State var state: HistroyState = .notEmptyHistory
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
            VStack(spacing: 0) {
                Text("История заказов")
                    .font(.custom(montserrat, size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 48)
                
                if state == .emptyHistory {
                    EmptyHistory()
                } else {
                    ScrollView (.vertical, showsIndicators: false) {
                        VStack(spacing: 22) {
                            if let orders = tabVM.profile?.orders {
                            ForEach(orders, id: \.id) { item in
                                HistoryItemView(order: item)
                            }
                            }
                        }
                        .padding(.vertical, 20)
                    }
                    .padding(.top, 21)
                }
                
            }
            .padding(.horizontal, 44)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if let _ = tabVM.profile?.orders {
                state = .notEmptyHistory
            } else {
                state = .emptyHistory
            }
        }
    }
}

extension HistoryView {
    
    //MARK: - Navigation Bar
    @ViewBuilder func NavigationBar() -> some View {
        NavBarView {
            Text("АККАУНТ".uppercased())
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
    
    //MARK: - Empty Cart
    @ViewBuilder func EmptyHistory() -> some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 8) {
                Text("УПС")
                    .foregroundColor(Color.black)
                    .font(.custom(montserrat, size: 20))
                    .fontWeight(.bold)
                Text("Заказов пока не было")
                    .foregroundColor(Color("bar"))
                    .font(.custom(montserrat, size: 20))
                    .fontWeight(.medium)
            }
            Spacer()
        }
    }
    
}

