//
//  extractCalculatesFromAction.swift
//  FP
//
//  Created by Song Jihyuk on 2023/04/28.
//

import Foundation

var shoppingCart: [Item] = []
var shoppingCartTotal: Double = 0

// addItemToCart는 전역변수를 수정하기 때문에 액션이다.
func addItemToCart(item: Item) {
    shoppingCart.append(item)
    calculateCartTotal()
    
}

// calculateCartTotal 역시 전역변수를 수정하기 때문에 액션이다.
func calculateCartTotal() {
    shoppingCartTotal = 0
    for i in 0..<shoppingCart.count {
        var itemPrice = shoppingCart[i].price
        shoppingCartTotal += itemPrice
    }
    changeButton()
    calculateTax()
}

// changeButton도 뷰와 공유할 bool값을 변경하기 때문에 액션이다.
func changeButton() {
    if shoppingCartTotal >= 20 {
        // 무료 배송이 가능하다고 적힌 버튼을 활성화하는 bool 값
    } else {
        // 배송비가 부과되는 기본 버튼을 활성화하는 bool 값
    }
}

// calculateTax도 전역변수를 수정하기 때문에 액션이다.
func calculateTax() {
    shoppingCartTotal += shoppingCartTotal*0.1
}

struct Item {
    let name: String
    let price: Double
}

