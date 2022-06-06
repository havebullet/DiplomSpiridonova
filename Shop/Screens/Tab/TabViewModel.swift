//
//  TabViewModel.swift
//  Shop
//
//  Created by Настя on 15.04.2022.
//

import Foundation
import SwiftUI

enum Tabs: String, CaseIterable {
    case menu = "menu"
    case home = "home"
    case cart = "cart"
}

class TabViewModel: ObservableObject {
    
    
    @Published var selection: Tabs = .home
    @Published var searchText: String = ""
    
    //MARK: - Sign In
    @Published var error: String = ""
    @Published var showError: Bool = false
    @Published var alertMessage = ""
    @AppStorage("isAuth") var isAuth: Bool = false
    @Published var profile: User?
    
    func signIn(email: String, password: String, completion: () -> ()) {
        if !email.isEmpty && !password.isEmpty {
            let user = users.filter({ $0.email.lowercased() == email.lowercased() }).first
            if let userPassword = user?.password {
                if password == userPassword {
                    profile = user
                    withAnimation {
                        isAuth = true
                    }
                    completion()
                } else {
                    alertMessage = "Ошибка"
                    error = "Неверный email или пароль"
                    showError = true
                }
            }
        } else {
            alertMessage = "Ошибка"
            error = "Заполните все поля!"
            showError = true
        }
    }
}

