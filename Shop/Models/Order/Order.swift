//
//  Order.swift
//  Shop
//
//  Created by Настя on 25.04.2022.
//

import Foundation

enum StatusOrder: String {
    case delivered = "Доставлен"
    case confirmed = "Принят"
}

struct Order: Identifiable {
    let id = UUID().uuidString
    let date: String
    let items: [CartItem]
    var totalPrice: Int {
        var result = 0
        for i in items {
            result += i.totalPrice
        }
        return result
    }
    let status: StatusOrder
    
    init(date: String,
         items: [CartItem],
         status: StatusOrder = .confirmed) {
        self.date = date
        self.items = items
        self.status = status
    }
}
