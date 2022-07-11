//
//  CheckoutRepo.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import Foundation
import ObjectMapper

class CheckoutRepo: Mappable {
    var msg: String?
    var status: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        msg    <- map["msg"]
        status   <- map["status"]
    }
}
