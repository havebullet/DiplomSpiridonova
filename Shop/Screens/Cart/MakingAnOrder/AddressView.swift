//
//  AddressView.swift
//  Shop
//
//  Created by Настя on 19.04.2022.
//

import SwiftUI

struct AddressView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showError: Bool = false
    @State var showNextStep: Bool = false
    @State var address: String = ""
    @State var apartment: String = ""
    @State var intercom: String = ""
    @State var entrance: String = ""
    @State var floor: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
            VStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 11){
                    Text("Адрес получателя")
                        .foregroundColor(Color.black)
                        .font(.custom(montserrat, size: 20))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Заказ доставят на указанный адрес")
                        .foregroundColor(Color("bar"))
                        .font(.custom(montserrat, size: 12))
                        .multilineTextAlignment(.leading)
                }
                .padding(.top, 38)
                
                VStack(spacing: 18) {
                    //Address
                    CustomTextField(text: $address, placeholder: "Адрес доставки")
                    HStack(spacing: 40) {
                        //Квартира
                        CustomTextField(text: $apartment, placeholder: "Квартира")
                        //Домофон
                        CustomTextField(text: $intercom, placeholder: "Домофон")
                    }
                    HStack(spacing: 40) {
                        //Подъезд
                        CustomTextField(text: $entrance, placeholder: "Подъезд")
                        //Этаж
                        CustomTextField(text: $floor, placeholder: "Этаж")
                    }
                }
            }
            .padding(.horizontal, 38)
            Spacer()
            CustomButton(title: "ДАЛЬШЕ") {
                if checkFields() {
                    showNextStep = true
                } else {
                    showError = true
                }
                
            }
            .padding(.horizontal, 52)
            .padding(.bottom, 52)
            .fullScreenCover(isPresented: $showNextStep, content: {
                TermsView()
            })
            .alert(isPresented: $showError) {
                Alert(title: Text("Ошибка"), message: Text("Заполните все поля!"), dismissButton: .default(Text("OK")))
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
    
    //MARK: - Methods
    func checkFields() -> Bool {
        if !address.isEmpty && !apartment.isEmpty && !intercom.isEmpty && !entrance.isEmpty && !floor.isEmpty {
            return true
        } else {
            return false
        }
    }
}

extension AddressView {
    
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

