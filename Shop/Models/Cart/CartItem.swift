//
//  CartItem.swift
//  Shop
//
//  Created by Настя on 17.04.2022.
//

import Foundation

class CartItem: Identifiable {
    let id = UUID().uuidString
    let item: Item
    var count: Int
    var totalPrice: Int {
        return item.price * count
    }
    
    init(item: Item, count: Int = 0) {
        self.item = item
        self.count = count
    }
}
