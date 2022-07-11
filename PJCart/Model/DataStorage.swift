//
//  DataStorage.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import Foundation

class CartDataStorage {
    static let sharedInstance = CartDataStorage()
    
    var cartData: [GoodsRepo.Goods] = [] {
        didSet{
            if let btn = buttonCart{
                btn.setCount(cartData.count)
            }
        }
    }
    var buttonCart: ButtonCart?
    
    private init() {
        
    }
}

struct LoginInfo {
    var account: String?
    var password: String?
}

class UserDataStorage {
    static let sharedInstance = UserDataStorage()
    
    var userData: UserLoginRepo?
    //var loginInfo: LoginInfo?  ///aaaa要儲存帳密 && 做自動登入!!!
    
    private init() {
        
    }
}

//存全域變數
class AppDataStorage {
    static let sharedInstance = AppDataStorage()
    
    var mainTabbar: MainTabbarViewController?
    
    private init() {
        
    }
}






