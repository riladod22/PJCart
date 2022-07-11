//
//  ApiService.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import Foundation
import Alamofire
import ObjectMapper

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    //MARK: GoodView
    func getGoodList(completion:@escaping ([GoodsRepo.Goods]?, Error?) -> Void){
        
        
        var result: [GoodsRepo.Goods] = []
        
        if let json = dummyResult("GoodsList") {
            let repo = Mapper<GoodsRepo>().map(JSONString:json)
            result = repo?.goods_list ?? []
        }
        completion(result,nil)
        
        /*
        WebService.sharedInstance.getHttpRequest(nil, method: "GoodsList"){ response in
            //
            var result: [GoodsRepo.Goods] = []
            
            if case .success = response.result {
                
                if let data = response.data {
                    if let json = String(data: data, encoding: .utf8) {
                        let repo = Mapper<GoodsRepo>().map(JSONString:json)
                        result = repo?.goods_list ?? []
                    }
                }else{
                    //print("no response data")
                }
                
            }else{
                print(response.error!)
            }
            
            completion(result,response.error)
        }*/
    }
    
    //MARK: MemberView
    func postUserLogin(username: String, password: String, completion:@escaping (UserLoginRepo?, Error?) -> Void){
        
        var result: UserLoginRepo?
        
        if let json = dummyResult("UserLogin") {
            result = Mapper<UserLoginRepo>().map(JSONString:json)
        }
        completion(result,nil)
        
        /*
        let parameter: [String: String] = ["username":username, "password":password]
         
        WebService.sharedInstance.postHttpRequest(parameter, method: "UserLogin") { response in
            
            var result: UserLoginRepo?
            
            if case .success = response.result {

                if let data = response.data {
                    if let json = String(data: data, encoding: .utf8) {
                        result = Mapper<UserLoginRepo>().map(JSONString:json)
                    }
                }else{
                    //print("no response data")
                }
                
            }else{
                print(response.error!)
            }
            
            completion(result,response.error)
        }*/
    }
    
    //MARK: CartView
    func postCheckout(id: String, goods: [String:Int], completion:@escaping (CheckoutRepo?, Error?) -> Void){
        
        var result: CheckoutRepo?
        
        if let json = dummyResult("Checkout") {
            result = Mapper<CheckoutRepo>().map(JSONString:json)
        }
        completion(result,nil)
        
        /*
        let parameter: [String: Any] = ["id":id, "goods":goods]
        
        WebService.sharedInstance.postHttpRequest(parameter, method: "Checkout") { response in
            
            var result: CheckoutRepo?
            
            if case .success = response.result {

                if let data = response.data {
                    if let json = String(data: data, encoding: .utf8) {
                        result = Mapper<CheckoutRepo>().map(JSONString:json)
                    }
                }else{
                    //print("no response data")
                }
                
            }else{
                print(response.error!)
            }
            
            completion(result,response.error)
        }
         */
    }
    
}

extension ApiService{
    
    func dummyResult(_ method:String) -> String? {
        
        sleep(2)
        
        var result: String?
        
        switch method {
        case "GoodsList":
            result = goodsListJSON
        case "UserLogin":
            result = userLoginJSON
        case "Checkout":
            result = checkoutJSON
        default:
            break
        }
        
        return result
    }
}

private let goodsListJSON = """
{
\"goods_list\" : [{
                   \"gid\" : \"1\",
                   \"img\" :   \"https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/83a07b66-5835-4895-93ba-e0e5bd215ac9/zoomx-invincible-run-flyknit-2-%E7%94%B7%E6%AC%BE%E8%B7%AF%E8%B7%91-QZ3ql0.png\", \
                   \"name\" : \"Nike ZoomX Invincible Run Flyknit 2\",
                   \"available\" : true,
                   \"prime\" : false,
                   \"price_original\" : 5500,
                   \"price\" : 5500
                },
                {
                   \"gid\" : \"2\",
                   \"img\" : \"https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/4a6c49a8-b485-4b1a-b9b3-f3088daace6c/air-force-1-react-%E7%94%B7-7gcHDc.png\",
                   \"name\" : \"Nike Air Force 1 React\",
                   \"available\" : true,
                   \"prime\" : false,
                   \"price_original\" : 0,
                   \"price\" : 4000
                },
                {
                   \"gid\" : \"3\",
                   \"img\" : \"https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/73225d61-b726-4f87-b389-a0555d931ec2/air-jordan-36-%E4%BD%8E%E7%AD%92%E7%94%B7%E6%AC%BE%E7%B1%83%E7%90%83-WWGCpF.png\",
                   \"name\" : \"Air Jordan XXXVI 低筒\",
                   \"available\" : true,
                   \"prime\" : false,
                   \"price_original\" : 0,
                   \"price\" : 5800
                },
                {
                   \"gid\" : \"4\",
                   \"img\" : \"https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/708ad5d8-85a6-4f5b-a955-1e290d4087e2/tiempo-legend-9-elite-fg-%E5%A4%A9%E7%84%B6%E5%81%8F%E7%A1%AC%E8%8D%89%E5%9C%B0%E8%B6%B3%E7%90%83%E9%87%98-cx8Zjd.png\",
                   \"name\" : \"Nike Tiempo Legend 9 Elite FG\",
                   \"available\" : true,
                   \"prime\" : false,
                   \"price_original\" : 7600,
                   \"price\" : 7600
                },
                {
                   \"gid\" : \"5\",
                   \"img\" : \"https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/c5d677b4-d0a4-4013-a58d-6b48d6d15185/air-jordan-3-retro-%E6%AC%BE-TJf2lm.png\",
                   \"name\" : \"Air Jordan 3 Retro\",
                   \"available\" : true,
                   \"prime\" : false,
                   \"price_original\" : 6700,
                   \"price\" : 6700
                },
                {
                   \"gid\" : \"6\",
                   \"img\" : \"https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/fd403e2c-a9ea-429e-9126-510b655efbfa/oneonta-be-true-%E6%B6%BC-vT3Lnx.png\",
                   \"name\" : \"Nike Oneonta Be True\",
                   \"available\" : true,
                   \"prime\" : false,
                   \"price_original\" : 0,
                   \"price\" : 3100
                },
                {
                   \"gid\" : \"7\",
                   \"img\" : \"https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/383a85e2-f68f-4686-b7da-c957d8ce0ce5/air-force-1-%E4%B8%AD%E7%AD%92-07-qs-%E7%94%B7-tlQ3Xf.png\",
                   \"name\" : \"Nike Air Force 1 中筒 '07 QS\",
                   \"available\" : true,
                   \"prime\" : false,
                   \"price_original\" : 4500,
                   \"price\" : 4500
                },
                {
                   \"gid\" : \"8\",
                   \"img\" : \"https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/bae3c49d-8f8e-4332-baa1-2aa9cb22f40a/jordan-delta-3-sp-%E7%94%B7-QZKkHQ.png\",
                   \"name\" : \"Jordan Delta 3 SP\",
                   \"available\" : true,
                   \"prime\" : false,
                   \"price_original\" : 4900,
                   \"price\" : 4900
                },
                {
                   \"gid\" : \"9\",
                   \"img\" : \"https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/a050fa4b-18a9-4050-a980-10b23d9fcb58/asuna-2-%E7%94%B7%E6%AC%BE%E6%8B%96-9CjWbM.png\",
                   \"name\" : \"Nike Asuna 2\",
                   \"available\" : true,
                   \"prime\" : false,
                   \"price_original\" : 1600,
                   \"price\" : 1600
                },
                {
                   \"gid\" : \"10\",
                   \"img\" : \"https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/72f94b86-ae17-4ae4-83d3-8ab5247ec9a7/air-max-plus-%E7%94%B7-4nfdrp.png\",
                   \"name\" : \"Nike Air Max Plus\",
                   \"available\" : true,
                   \"prime\" : false,
                   \"price_original\" : 4900,
                   \"price\" : 4900
                }]

}
"""

private let userLoginJSON = "{\"id\" : \"1\",\"name\" : \"PuJie Lee\",\"level\" : 3}"

private let checkoutJSON = "{ \"msg\" : \"結帳成功，感謝您的購買!\", \"status\" : 200 }"
