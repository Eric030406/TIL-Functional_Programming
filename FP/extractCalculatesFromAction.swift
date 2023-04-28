//
//  extractCalculatesFromAction.swift
//  FP
//
//  Created by Song Jihyuk on 2023/04/28.
//

import Foundation

var shoppingCart: [Item] = []
var shoppingCartTotal: Double = 0

// shoppingCart 전역변수를 수정하기 때문에 액션이다.
func addItemToCart(item: Item) {
    shoppingCart = addItem(cart: shoppingCart, item: item)
    calculateCartTotal()
    
}

// 지역변수에 인자값을 할당해서 지역변수를 수정하고 리턴하고 있다. 전역변수를 읽거나 수정하는게 없기 때문에 전부 명시적 입력, 출력이다. 따라서 계산이다.
func addItem(cart: [Item], item: Item) -> [Item] {
    var newCart = cart
    newCart.append(item)
    
    return newCart
}

// shoppingCartTotal 전역변수를 수정하기 때문에 액션이다.
func calculateCartTotal() {
    shoppingCartTotal = calculateItemTotal(cart: shoppingCart)
    changeButton()
    addTaxPrice()
}

// 지역변수 값을 수정하고 리턴하고 있다. 전역변수를 읽거나 수정하는게 없기 때문에 계산이다.
func calculateItemTotal(cart: [Item]) -> Double {
    var total: Double = 0
    for i in 0..<cart.count {
        var itemPrice = cart[i].price
        total += itemPrice
    }
    
    return total
}

// if나 else에서 @Published 프로퍼티 래퍼를 적용한 Bool 타입의 프로퍼티를 수정할 것이므로, 액션이다.
func changeButton() {
    if decideFreeShipping(total: shoppingCartTotal) {
        // 무료 배송이 가능하다고 적힌 버튼을 활성화하는 bool 값
    } else {
        // 배송비가 부과되는 기본 버튼을 활성화하는 bool 값
    }
}

// 인자값을 이용한 bool 값을 리턴하고 있다. 계산이다.
func decideFreeShipping(total: Double) -> Bool {
    return total >= 20
}

// shoppingCartTotal 전역변수를 수정하기 때문에 액션이다.
func addTaxPrice() {
    shoppingCartTotal += calculateTax(total: shoppingCartTotal)
}

// 지역변수에 인자값을 할당해서 연산한 값을 리턴하고 있기 때문에 계산이다.
func calculateTax(total: Double) -> Double {
    var total = total
    var taxRate: Double = 0.10
    
    return total*taxRate
}


struct Item {
    let name: String
    let price: Double
}

