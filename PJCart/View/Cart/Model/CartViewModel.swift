//
//  CartViewModel.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import UIKit

class CartViewData {
    var isLoading = Observerable<Bool>(value: false)
    var cartListData = Observerable<[CartViewCellData]>(value: [])
}

class CartViewModel{
    let apiService: ApiService
    var viewData: CartViewData
    weak var viewController: CartViewController?
    
    init(apiService: ApiService = ApiService(),
         viewData: CartViewData = CartViewData()) {
        self.apiService = apiService
        self.viewData = viewData
    }
    
    func start(_ viewController: CartViewController){
        
        self.viewController = viewController
        
        //設定列表
        var listData :[CartViewCellData] = []
        for goods in CartDataStorage.sharedInstance.cartData{
            listData.append(CartViewCellData.init(goods: goods))
        }
        viewData.cartListData.value = listData
    }
        
    func runCheckout() {
        //結帳
        
        let userId = UserDataStorage.sharedInstance.userData?.id ?? ""
        var buyGoods: [String:Int] = [:]
        for goods in viewData.cartListData.value {
            buyGoods[goods.gid] = goods.buy_count.value
        }
        
        viewData.isLoading.value = true
        
        ApiService.sharedInstance.postCheckout(id: userId, goods: buyGoods) { [weak self, weak viewController]  checkoutRepo, error in
            
            self?.viewData.isLoading.value = false
            
            if let repo = checkoutRepo {

                CartDataStorage.sharedInstance.cartData = []
                
                //"結帳成功，感謝您的購買!"
                if let viewController = viewController {
                    viewController.showAlertMessage(title: "訊息",
                                                    message:repo.msg ?? "" ,
                                                    target: viewController,
                                                    okEvent: {
                        viewController.dismiss(animated: true)
                    })
                }
            }else if let errMsg = error {
                print(errMsg) //show error message
            }
        }
    }
    
    func getTotalCostString() -> String{
        //取得小計
        var total = 0
        
        for goods in viewData.cartListData.value {
            total += (goods.price * goods.buy_count.value)
        }
        
        return "小計： \(total)元"
    }
    
    func removeGoodsFromCart(at index:Int) ->Void{
        
        //1.依照gid清除購物車內的資料
        let goodsId = viewData.cartListData.value[index].gid
        for itemIndex in 0 ..< CartDataStorage.sharedInstance.cartData.count {
            let cartItem = CartDataStorage.sharedInstance.cartData[itemIndex]
            if cartItem.gid == goodsId {
                CartDataStorage.sharedInstance.cartData.remove(at: itemIndex)
                break
            }
        }
        
        //2.清除列表的資料
        viewData.cartListData.value.remove(at: index)
        
    }
}
