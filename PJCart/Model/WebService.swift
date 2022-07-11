//
//  WebService.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import Foundation
import Alamofire


class WebService {
    static let sharedInstance = WebService()
    
    func getHttpRequest(_ paramaters: [String:String]?, method: String , completion:@escaping (AFDataResponse<Data?>) -> Void){
        
        let url = Domain.URL_API+method
        
        AF.request(url, method: .get, parameters: paramaters, encoding:URLEncoding.queryString, headers:nil)
            .validate(statusCode: 200..<300)
            .response { response in
                
                completion(response)
            }
    }
    
    func postHttpRequest(_ paramaters: [String:Any]?, method: String , completion:@escaping (AFDataResponse<Data?>) -> Void){
        
        let url = Domain.URL_API+method
        
        AF.request(url, method: .post, parameters: paramaters, encoding: URLEncoding.queryString, headers:nil)
            .validate(statusCode: 200..<300)
            .response { response in
                
                completion(response)
            }
    }
}
