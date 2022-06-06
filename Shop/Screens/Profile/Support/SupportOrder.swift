import Foundation
import SwiftUI
import Introspect

struct SupportOrder: View {
    @Environment(\.presentationMode) var presentationMode
    @State var name = ""
    @State var numberOrder = ""
    @State var numberSephora = ""
    @State var email = ""
    @State var message = ""
    @State var showMenu = false
    @State var category = "Выберите категорию"
    @State var showAlert = false
    @State var confirmed = false
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
            ScrollView {
                VStack(spacing: 0) {
                    Text("Оставить заявку")
                        .font(.custom(montserrat, size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 48)
                        .padding(.bottom, 33)
                    
                    VStack(spacing: 23) {
                        CustomTextField(text: $name, placeholder: "Имя")
                        CustomTextField(text: $numberOrder, placeholder: "Номер заказа")
                        CustomTextField(text: $numberSephora, placeholder: "Номер карты SEPHORA")
                        CustomTextField(text: $email, placeholder: "E-mail")
                    }
                    .padding(.bottom, 27)
            
                    Menu {
                        Button {
                            self.category = "Отмена заказа"
                        } label: {
                            Text("Отмена заказа")
                        }
                        Button {
                            self.category = "Доставка"
                        } label: {
                            Text("Доставка")
                        }
                        Button {
                            self.category = "Качество товара"
                        } label: {
                            Text("Качество товара")
                        }
                        Button {
                            self.category = "Оплата"
                        } label: {
                            Text("Оплата")
                        }
                        Button {
                            self.category = "Ассортимент"
                        } label: {
                            Text("Ассортимент")
                        }
                        Button {
                            self.category = "Качество обслуживания"
                        } label: {
                            Text("Качество обслуживания")
                        }
                        Button {
                            self.category = "Другое"
                        } label: {
                            Text("Другое")
                        }
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(category.uppercased())
                                .font(.custom(montserrat, size: 15))
                                .foregroundColor(Color(#colorLiteral(red: 0.0431372549, green: 0.4196078431, blue: 0.7647058824, alpha: 1)))
                            
                            
                            Rectangle()
                                .frame(height: 0.3)
                                .foregroundColor(Color(#colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 1)))
                        }
                    }
                    .padding(.bottom, 27)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Текст сообщения")
                            .foregroundColor(Color.black)
                            .font(.custom(montserrat, size: 14))
                        
                        TextEditor(text: $message)
                            .frame(height: 110)
                            .overlay(
                                Rectangle()
                                    .stroke(lineWidth: 0.3)
                                    .foregroundColor(Color.black)
                            )
                    }
                    .padding(.bottom, 27)
                    
                    Button {
                        showAlert = true
                    } label: {
                        Text("отправить запрос")
                            .font(.custom(montserrat, size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(5)
                    }
                    .padding(.bottom, 5)
                    .alert("Запрос успешно отправлен", isPresented: $showAlert) {
                        Button {
                            confirmed = true
                        } label: {
                            Text("ОК")
                        }

                    }
                    
                    Text("Переписка строго конфиденциальна и никому не будет доступа, кроме специалиста службы поддержки.")
                        .font(.custom(montserrat, size: 12))
                        .foregroundColor(Color.black)
                        .padding(.bottom, 34)
                }
                .padding(.horizontal, 44)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .introspectNavigationController(customize: { navController in
                if confirmed {
                    navController.popToRootViewController(animated: true)
                }
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

extension SupportOrder {
    
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
}
