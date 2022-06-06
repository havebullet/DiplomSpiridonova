//
//  CartDataModel.swift
//  Shop
//
//  Created by Настя on 18.04.2022.
//

import Foundation

class CartDataModel: ObservableObject {
    
    //MARK: - Properties
    @Published var items: [CartItem] = []
    
    var totalCount: Int {
        var count = 0
        for item in items {
            count += item.count
        }
        return count
    }
    var totalPrice: Int {
        var price = 0
        for item in items {
            price += item.totalPrice
        }
        return price
    }
    
    //MARK: - Methods
    func getAllItems() {
        let items = items.map({ $0 })
        self.items = items
    }
    
    func addItem(item: Item) {
        if items.contains(where: { $0.item == item }) {
            if let cartItem = items.first(where: { $0.item == item }) {
                plusItemInCart(cartItem: cartItem)
            }
        } else {
            let cartItem = CartItem(item: item)
            cartItem.count += 1
            
            items.append(cartItem)
            getAllItems()
        }
    }
    
    func removeItem(item: Item) {
        items.removeAll(where: { $0.item.id == item.id })
        getAllItems()
    }
    
    func plusItemInCart(cartItem: CartItem) {
        if let item = items.first(where: { $0.item == cartItem.item }) {
            item.count += 1
        }
        getAllItems()
    }
    
    func minusItemInCart(cartItem: CartItem) {
        if let item = items.first(where: { $0.item == cartItem.item }) {
            if item.count > 1 {
                item.count -= 1
            } else {
                removeItem(item: item.item)
            }
            getAllItems()
        }
    }
    
    func checkingItemInCart(item: Item) -> Bool {
        if items.contains(where: { $0.item == item }) {
            return true
        } else {
            return false
        }
    }
    
    func clearCart() {
        items.removeAll()
    }
}
