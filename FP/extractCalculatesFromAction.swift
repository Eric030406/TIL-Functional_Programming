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
    shoppingCart = addElement(array: shoppingCart, element: makeItem(name: "Converse", price: 140, quantity: 10))
    calculateCartTotal()
    shoppingCart = blackFridayPromotionSafe(cart: shoppingCart)
    
    
    
}

//MARK: 방어적 복사
func blackFridayPromotionSafe(cart: [Item]) -> [Item] {
    var cartCopy = shoppingCart
    blackFridayPromotion(shoppingCart)
    return cartCopy
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
func changeButton(cart: [Item]) {
    if decideFreeShipping(cart: cart) {
        // 무료 배송이 가능하다고 적힌 버튼을 활성화하는 bool 값
    } else {
        // 배송비가 부과되는 기본 버튼을 활성화하는 bool 값
    }
}

// 인자값을 이용한 bool 값을 리턴하고 있다. 계산이다.




// 지역변수에 인자값을 할당해서 연산한 값을 리턴하고 있기 때문에 계산이다.
func calculateTax(total: Double) -> Double {
    var total = total
    var taxRate: Double = 0.10
    
    return total*taxRate
}


struct Item {
    let name: String
    var price: Double
    var quantity: Int
}



//MARK: Copy-On-Write를 적용시켜서 통제 가능한 범위에서 불변성 구현

func objectSet(_ object: [Item], key: String, value: Double) -> [Item] {
    var copy = object
    
    for i in 0..<copy.count {
        if copy[i].name == key {
            copy[i].price = value
        }
    }
    
    return copy
}

func objectDelete(_ object: [Item], key: String) -> [Item] {
    var copy = object
    for i in 0..<copy.count {
        if copy[i].name == key {
            copy.remove(at: i)
        }
    }
    return copy
}



let shopping = [Item(name: "shoes", price: 10, quantity: 3),
                Item(name: "socks", price: 3, quantity: 20),
                Item(name: "pants", price: 27, quantity: 5),
                Item(name: "t-shirt", price: 7, quantity: 10),
]


func setQuantityByName(cart: [Item], name: String, quantity: Int) -> [Item] {
    var newCart = cart
    for i in 0..<newCart.count {
        if newCart[i].name == name {
            newCart[i].quantity = quantity
        }
    }
    
    return newCart
}







func blackFridayPromotion(_ shoppingCart: [Item]) {
    
}


//MARK: 반복문을 isInCart 함수로 빼서, freeTieClip 함수의 추상화 계층의 단계를 비슷하게 맞춤

func freeTieClip(cart: [Item]) -> [Item] {
    var newCart = cart
    var hasTie = isInCart(cart: newCart, name: "tie")
    var hasTieClip = isInCart(cart: newCart, name: "tie Clip")
    
    
    if hasTie && !hasTieClip {
        var tieClip = makeItem(name: "tie Clip", price: 0, quantity: 1)
        newCart = addItem(cart: newCart, item: tieClip)
    }
    
    return newCart
}

func decideFreeShipping(cart: [Item]) -> Bool {
    return calculateItemTotal(cart: cart) >= 20
}

// shoppingCartTotal 전역변수를 수정하기 때문에 액션이다.
func addTaxPrice() {
    shoppingCartTotal += calculateTax(total: shoppingCartTotal)
}





// cart의 구조만 알고 있는 함수..? 흠
func addItem(cart: [Item], item: Item) -> [Item] {
    return addElement(array: cart, element: item)
}

// MARK: isInCart 함수가 반복문과 array index같은 낮은 계층의 기능을 사용했었는데, indexOfItem 함수로 계층을 명확히 함
func isInCart(cart: [Item], name: String) -> Bool {
    return indexOfItem(cart: cart, name: name) != nil
}

// shoppingCartTotal 전역변수를 수정하기 때문에 액션이다.
func calculateCartTotal() {
    shoppingCartTotal = calculateItemTotal(cart: shoppingCart)
    changeButton(cart: shoppingCart)
    addTaxPrice()
}


// MARK: 함수에서 사용되는 다른 함수나 기능들의 계층을 맞춰주기 위해 반복문을 indexOfItem 함수로 뺌
func removeItemByName(cart: [Item], name: String) -> [Item] {
    var index: Int? = indexOfItem(cart: cart, name: name)
    var newCart = cart
    
    if index != nil {
        newCart = removeItems(array: newCart, index: index!)
        return newCart
    }
    
    return newCart
}

func indexOfItem(cart: [Item], name: String) -> Int? {
    for i in 0..<cart.count {
        if cart[i].name == name {
            return i
        }
    }
    return nil
}




// Item의 구조만 알고 있는 함수
func makeItem(name: String, price: Double, quantity: Int) -> Item {
    return Item(name: name, price: price, quantity: quantity)
}

func setPrice(item: [Item], newPrice: Double) -> [Item] {
    return objectSet(item, key: "T-shirt", value: newPrice)
}


func removeItems(array: [Item], index: Int) -> [Item] {
    var copy = array
    copy.remove(at: index)
    
    return copy
}

// addItem 함수에서 일반적으로 사용할 수 있는 유틸리티 함수를 추출. 어느 배열에서나 사용할 수 있다.
func addElement<T>(array: [T], element: T) -> [T] {
    var newArray = array
    newArray.append(element)
    
    return newArray
}
