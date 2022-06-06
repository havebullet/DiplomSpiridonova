//
//  LoginView.swift
//  Shop
//
//  Created by Настя on 15.04.2022.
//

import SwiftUI

enum LoginState: String, CaseIterable {
    case signUp
    case signIn
}

struct LoginView: View {
    
    @EnvironmentObject var tabVM: TabViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var state: LoginState = .signIn
    @State var email: String = ""
    @State var password: String = ""
    @State var rePassword: String = ""
    @State var showAlert = false
    
    var body: some View {
        VStack(spacing: 0) {            
            ZStack {
                BackgroundImage()
                
                VStack(spacing: 0) {
                    MainView()
                        .padding(.top, 80)
                    Spacer()
                    CustomButton(title: state == .signIn ? "РЕГИСТРАЦИЯ" : "ВОЙТИ", foregroundColor: .black, backgroundColor: .white, action: {
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.2)) {
                            if state == .signIn {
                                state = .signUp
                            } else {
                                state = .signIn
                            }
                        }
                    })
                        .animation(.interactiveSpring(), value: state)
                        .padding(.bottom, 52)
                }
                .padding(.horizontal, 24)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension LoginView {
    
    //MARK: - Background Image
    @ViewBuilder func BackgroundImage() -> some View {
        GeometryReader { reader in
            let size = reader.size
            
            Image("bg")
                .resizable()
                .frame(width: size.width, height: size.height)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
    
    //MARK: - Sign In View
    @ViewBuilder func SignInView() -> some View {
        VStack(spacing: 30) {
            //Email
            CustomTextField(text: $email, placeholder: "Электронная почта")
            //Password
            CustomTextField(text: $password, placeholder: "Пароль")
            
            Button {
                
            } label: {
                Text("Забыли пароль?")
                    .underline(true, color: Color(#colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 1)))
                    .font(.custom(montserrat, size: 13))
                    .fontWeight(.light)
                    .foregroundColor(Color(#colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 1)))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 32)
    }
    
    //MARK: - Sign Up View
    @ViewBuilder func SignUpView() -> some View {
        VStack(spacing: 42) {
            VStack(spacing: 30) {
                //Email
                CustomTextField(text: $email, placeholder: "Электронная почта")
                //Password
                CustomTextField(text: $password, placeholder: "Пароль")
                //RePassword
                CustomTextField(text: $rePassword, placeholder: "Введите пароль еще раз")
            }
            Text("Вам на почту придет ссылка, просьба подтвердить свою почту")
                .font(.custom(montserrat, size: 12))
                .fontWeight(.light)
                .foregroundColor(Color(#colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 1)))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 32)
    }
    
    //MARK: - Main View
    @ViewBuilder func MainView() -> some View {
        VStack(spacing: 0) {
            Text(state == .signIn ? "Вход" : "Регистрация")
                .foregroundColor(Color.black)
                .font(.custom(montserrat, size: 30))
                .fontWeight(.bold)
                .animation(.default, value: state)
                .padding(.vertical, 32)
            
            switch state {
                
            case .signIn:
                SignInView()
                
            case .signUp:
                SignUpView()
                
            }
            
            Button {
                if state == .signIn {
                    tabVM.signIn(email: email, password: password) {
                        presentationMode.wrappedValue.dismiss()
                    }
                } else {
                    tabVM.alertMessage = "Регистрация прошла успешно!"
                    tabVM.error = "Пожалуйста, подтвердите регистрацию на почте"
                    tabVM.showError = true
                }
            } label: {
                Text(state == .signIn ? "ВОЙТИ" : "ЗАРЕГИСТРИРОВАТЬСЯ")
                    .font(.custom(montserrat, size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .background(Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)))
            }
        }
        .background(Color.white)
        .clipShape(CustomShape(corners: [.bottomLeft, .bottomRight], size: 10))
        .padding(.horizontal)
        .alert(isPresented: $tabVM.showError) {
            Alert(title: Text(tabVM.alertMessage), message: Text(tabVM.error), dismissButton: .default(Text("OK"), action: {
                withAnimation {
                    state = .signIn
                }
            }))
        }
    }
    
}
