//
//  SupportView.swift
//  Shop
//
//  Created by Student on 20.04.2022.
//

import SwiftUI

struct SupportView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Контакты")
                    .font(.custom(montserrat, size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 48)
                    .padding(.bottom, 33)
                
                LabelWithBorder(text: "Служба поддержки клиентов")
                    .padding(.bottom, 23)
                Text("Хочешь задать вопрос? Нужна помощь?")
                    .foregroundColor(Color.black)
                    .font(.custom(montserrat, size: 13))
                    .padding(.bottom, 21)
                
                NavigationLink {
                    SupportOrder()
                } label: {
                    Text("отправить запрос")
                        .font(.custom(montserrat, size: 15))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(width: 220, height: 40)
                        .background(Color.black)
                        .cornerRadius(5)
                }
                .buttonStyle(CustomButtonStyle())
                .padding(.bottom, 39)
                
                LabelWithBorder(text: "напиши нам!")
                    .padding(.bottom, 23)
                
                VStack(alignment: .leading, spacing: 15){
                    Text("Помоги нам стать лучше!")
                        .foregroundColor(Color.black)
                        .font(.custom(montserrat, size: 13))
                        
                    HStack(spacing: 0){
                        Text("Написать на ")
                            .foregroundColor(Color.black)
                            .font(.custom(montserrat, size: 13))
                        Text("profmua@mail.ru")
                            .underline()
                            .foregroundColor(Color.black)
                            .font(.custom(montserrat, size: 13))
                            .bold()
                    }
                }
            }
            .padding(.horizontal, 44)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

extension SupportView {
    
    //MARK: - Navigation Bar
    @ViewBuilder func NavigationBar() -> some View {
        NavBarView {
            Text("ПОДДЕРЖКА".uppercased())
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
    
    @ViewBuilder func LabelWithBorder(text: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(text.uppercased())
                .foregroundColor(Color.black)
                .font(.custom(montserrat, size: 13))
                .bold()
            Rectangle()
                .foregroundColor(Color.init(#colorLiteral(red: 0.7302243114, green: 0.7302241921, blue: 0.7302241921, alpha: 1)))
                .frame(height: 0.5)
        }
    }
    
}
