//
//  main.swift
//  FP
//
//  Created by Song Jihyuk on 2023/04/26.
//

import Foundation


// Actions

// 구독자는 시간에 따라서 바뀔 수 있기 때문에, 함수 실행 시점에 의존한다. 따라서 Action이다.
func getSubscriberList() -> [User] {
    
    //액션을 통해 가져온 구독자 목록은 Data이다.
    return userTable
}

// 쿠폰 역시 시간에 따라서 목록이 바뀔 수 있기 때문에, 실행 시점에 의존한다. 따라서 Action이다.
func getCouponList() -> [Coupon] {
    
    //액션을 통해 가져온 쿠폰 목록은 Data이다.
    return coupons
}


// Calculates

// 쿠폰들 목록에서 원하는 랭크에 해당하는 쿠폰을 필터링한다. 같은 인자값을 넣을 때, 항상 같은 값을 return 하기 때문에 Calculate이다.
func selectCouponByRank(coupons: [Coupon], rank: Rank) -> [Coupon] {
    return coupons.filter { $0.rank == rank }
}

// 구독자의 추천수에 맞는 쿠폰을 할당해주고, 쿠폰 랭크에 맞는 이메일을 전송해준다. 같은 인자값을 넣을 때, 항상 같은 값을 return 하기 때문에 Calculate이지만, 좀 더 세분화해서 쪼갤 수 있어 보인다. 함수 이름도 역할과 맞지 않는 것 같다.
func decideCouponToUser(userTable: [User], couponTable: [Coupon]) -> [User] {
    var userData = userTable
    let bestCoupon = selectCouponByRank(coupons: couponTable, rank: .Best)
    let goodCoupon = selectCouponByRank(coupons: couponTable, rank: .Good)
    
    
    for index in 0..<userTable.count {
        if userData[index].recommandCount >= 12 {
            userData[index].couponList = bestCoupon
            var emails = emailForSubscriber(subscriber: userData[index], rank: .Best)
        }
        else if userData[index].recommandCount >= 6 {
            userData[index].couponList = goodCoupon
            var emails = emailForSubscriber(subscriber: userData[index], rank: .Good)
        } else {
            userData[index].couponList = []
        }
    }
    
    return userData
}

func emailForSubscriber(subscriber: User, rank: Rank) -> Email? {
    if rank == .Best {
        return Email(from: "Apple Developer Academy @ Postech", to: subscriber.email, subject: "For Best Customer!", body: "Thanks to your use, We finally adapted...")
    } else if rank == .Good {
        return Email(from: "Apple Developer Academy @ Postech", to: subscriber.email, subject: "For Good Customer!", body: "Thanks to your use, We finally adapted...")
    } else {
        return nil
    }
}

// Datas

var userTable: [User] = [User(email: "athdwlgur@gmail.com", recommandCount: 3),
                         User(email: "real.dassy@gmail.com", recommandCount: 12),
                         User(email: "real.dassy@naver.com", recommandCount: 5),
                         User(email: "songys0919@naver.com", recommandCount: 6),
]

var coupons: [Coupon] = [Coupon(code: "45%", rank: .Best),
                         Coupon(code: "15%", rank: .Good),
                         Coupon(code: "0", rank: .bad),
                         Coupon(code: "-15%", rank: .bad),
                         Coupon(code: "75%", rank: .Best),
                         Coupon(code: "80%", rank: .Best),
]



struct Email {
    let from: String
    let to: String
    let subject: String
    let body: String
}

struct User {
    let email: String
    let recommandCount: Int
    var couponList: [Coupon] = []
}

struct Coupon {
    let code: String
    let rank: Rank
}

enum Rank {
    case Best
    case Good
    case bad
}





