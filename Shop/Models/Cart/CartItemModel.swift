//
//  CartItem.swift
//  Shop
//
//  Created by Даня on 17.04.2022.
//

import Foundation

class CartItem {
    let item: Item
    let count: Int = 0
    var totalPrice: Int {
        return item.price * count
    }
    
    init(item: Item) {
        self.item = item
    }
}
