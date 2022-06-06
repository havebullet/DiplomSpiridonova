//
//  ProfileView.swift
//  Shop
//
//  Created by Настя on 18.04.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var tabVM: TabViewModel
    @AppStorage("isAuth") var isAuth = false
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
            
            if isAuth {
                MyDataView()
            } else {
                LoginView()
            }
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

extension ProfileView {
    
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
    
    //MARK: - My Data View
    @ViewBuilder func MyDataView() -> some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 34) {
                    Text("Мои данные")
                        .font(.custom(montserrat, size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 18) {
                        //Email
                        InfoItemView(title: tabVM.profile?.email ?? "")
                        //Name
                        InfoItemView(title: tabVM.profile?.name ?? "")
                        //Phone
                        InfoItemView(title: tabVM.profile?.phone ?? "")
                    }
                }
                .padding(.top, 48)
                .padding(.bottom, 65)
                VStack(spacing: 16) {
                    NavigationLink {
                        HistoryView()
                    } label: {
                        Text("ИСТОРИЯ ЗАКАЗОВ")
                            .fontWeight(.semibold)
                    }
                    .buttonStyle(ProfileButtonStyle())
                    Button {
                        withAnimation {
                            isAuth = false
                        }
                    } label: {
                        Text("ВЫЙТИ")
                            .fontWeight(.semibold)
                    }
                    .buttonStyle(ProfileButtonStyle())
                    NavigationLink {
                        SupportView()
                    } label: {
                        Text("ПОДДЕРЖКА")
                            .fontWeight(.semibold)
                    }
                    .buttonStyle(ProfileButtonStyle())
                }
            }
            .padding(.horizontal, 44)
        }
        .background(Color.white)
    }
    
}
