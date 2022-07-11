//
//  UserLoginRepo.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import Foundation
import ObjectMapper

class UserLoginRepo: Mappable {
    var id: String?
    var name: String?
    var level: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
        level   <- map["level"]
    }
}
