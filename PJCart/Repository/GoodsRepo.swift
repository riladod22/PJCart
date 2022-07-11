//
//  GoodsRepo.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import Foundation
import ObjectMapper

class GoodsRepo: Mappable {
    var goods_list: [Goods]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        goods_list <- map["goods_list"]
    }
    
    class Goods: Mappable {
        var gid: String?   //ID
        var img: String?   //圖片
        var name: String?  //名稱
        var available: Bool?  //販售中
        var prime: Bool?  //精選商品
        var price_original: Int?  //原價
        var price: Int?  //售價
        
        //
        //var buy_count: Int = 0  //購買數量
        
        required convenience init?(map: Map) {
            self.init()
        }
        
        func mapping(map: Map) {
            gid             <- map["gid"]
            img             <- map["img"]
            name            <- map["name"]
            available       <- map["available"]
            prime           <- map["prime"]
            price_original  <- map["price_original"]
            price           <- map["price"]
        }
        
        func copyToCart() -> Goods{
            let result = Goods.init()
            result.gid = gid
            result.img = img
            result.name = name
            result.available = available
            result.prime = prime
            result.price_original = price_original
            result.price = price
            //result.buy_count = 1 discard
            
            return result
        }
    }

}
