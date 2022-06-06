//
//  MyContactView.swift
//  Shop
//
//  Created by Настя on 18.04.2022.
//

import SwiftUI

struct MyContactView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var tabVM: TabViewModel
    @AppStorage("isAuth") var isAuth = false
    @State var showLogin = false
    @State var showNextStep: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
            VStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 11){
                    Text("Мои контакты")
                        .foregroundColor(Color.black)
                        .font(.custom(montserrat, size: 20))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Пожалуйста, проверьте свои указанные данные в профиле")
                        .foregroundColor(Color("bar"))
                        .font(.custom(montserrat, size: 12))
                        .multilineTextAlignment(.leading)
                }
                .padding(.top, 38)
                
                if isAuth {
                    VStack(spacing: 18) {
                        //Email
                        InfoItemView(title: tabVM.profile?.email ?? "")
                        //Name
                        InfoItemView(title: tabVM.profile?.name ?? "")
                        //Phone
                        InfoItemView(title: tabVM.profile?.phone ?? "")
                    }
                } else {
                    Button(action: {
                        showLogin = true
                    }, label: {
                        Text("ВОЙТИ / ЗАРЕГИСТРИРОВАТЬСЯ")
                    })
                    .buttonStyle(PinkButtonStyle())
                    .padding(.top)
                    .fullScreenCover(isPresented: $showLogin) {
                        ProfileView()
                    }
                    
                }
            }
            .padding(.horizontal, 38)
            Spacer()
            CustomButton(title: "ДАЛЬШЕ") {
                showNextStep = true
            }
            .padding(.horizontal, 52)
            .padding(.bottom, 52)
            .disabled(!isAuth)
            .opacity(isAuth ? 1 : 0.75)
            .overlay(
                NavigationLink(isActive: $showNextStep, destination: {
                    ReceivingMethodView()
                }, label: {
                    EmptyView()
                })
            )
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

extension MyContactView {
    
    //MARK: - Navigation Bar
    @ViewBuilder func NavigationBar() -> some View {
        NavBarView {
            Text("Оформление".uppercased())
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
    
}
