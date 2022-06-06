//
//  User.swift
//  Shop
//
//  Created by Настя on 24.04.2022.
//

import Foundation

class User {
    let email: String
    let password: String
    let name: String
    let phone: String
    var orders: [Order]?
    init(email: String, password: String, name: String, phone: String, orders: [Order]?) {
        self.email = email
        self.password = password
        self.name = name
        self.phone = phone
        self.orders = orders
    }
}

let order = [Order(date: "11.01.2022",
                   items: [CartItem(item: items[3], count: 1),
                           CartItem(item: items[6], count: 3)],
                   status: .delivered),
             Order(date: "14.01.2022",
                   items: [CartItem(item: items[2], count: 4),
                           CartItem(item: items[4], count: 1),
                           CartItem(item: items[1], count: 1)],
                   status: .delivered),
             Order(date: "02.02.2022",
                   items: [CartItem(item: items[1], count: 2),
                           CartItem(item: items[5], count: 1),
                           CartItem(item: items[8], count: 1),
                           CartItem(item: items[6], count: 3)],
                   status: .delivered),
             Order(date: "08.03.2022", items: [CartItem(item: items[9], count: 1)]),
             Order(date: "17.04.2022", items: [CartItem(item: items[3], count: 1),
                                               CartItem(item: items[4], count: 2)],
                   status: .delivered),
             Order(date: "28.05.2022", items: [CartItem(item: items[2], count: 1),
                                               CartItem(item: items[7], count: 2)],
                   status: .confirmed)]

let users: [User] = [
    User(email: "VAYTS.NASTYA@MAIL.RU", password: "123456", name: "Настя", phone: "+7 (999) 999 99-99", orders: order),
    User(email: "TEST.TEST@MAIL.RU", password: "000000", name: "Юлия", phone: "+7 (999) 123 45-67", orders: nil)
]


