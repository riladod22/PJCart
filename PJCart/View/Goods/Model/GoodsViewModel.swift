//
//  GoodsViewModel.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

//import Foundation
import UIKit

//MARK: data
class GoodsViewData {
    var isLoading = Observerable<Bool>(value: false)
    var goodListData = Observerable<[GoodsRepo.Goods]>(value: [])
}

//MARK: view module
class GoodsViewModel {
    let apiService: ApiService
    var viewData: GoodsViewData
    
    init(apiService: ApiService = ApiService(),
        goodsViewData: GoodsViewData = GoodsViewData()) {
        self.apiService = apiService
        self.viewData = goodsViewData
    }
    
    func start(){
    
        self.viewData.isLoading.value = true
        
        getGoodList()
    }
    
    func getGoodList(){
        ApiService.sharedInstance.getGoodList { listData, error in
            
            self.viewData.isLoading.value = false
            
            if let listData = listData {
                self.viewData.goodListData.value = listData
            }else if let errMsg = error {
                print(errMsg) //show error message
            }
        }
    }
    
    @objc func pushToCartView(_ viewController: UIViewController){
        //push To CartView (need login)
        if UserDataStorage.sharedInstance.userData != nil {

            let cartViewController = CartViewController.init(nibName: "CartViewController", bundle: Bundle.main)
            cartViewController.title = "購物車"
            
            let navigationController = PJCartNavigationController()
            navigationController.setupAppearance()
            navigationController.setViewControllers([cartViewController], animated: false)
            navigationController.modalPresentationStyle = .fullScreen
            
            
            viewController.present(navigationController, animated: true)

        }else{
            //to member login view

            if let mainTabbar = AppDataStorage.sharedInstance.mainTabbar {
                mainTabbar.swiftToLoginView()
            }
        }
    }
    
    //MARK: good view cell delegate
    func addToCart(withIndex cellIdx: IndexPath){
        let cartDataStorage = CartDataStorage.sharedInstance
        let currentGoodItem = viewData.goodListData.value[cellIdx.row]
        var isAdded = false
        
        for addedGoodItem in cartDataStorage.cartData {
            if addedGoodItem.gid == currentGoodItem.gid {
                isAdded = true
                break
            }
        }
        
        if !isAdded {
            cartDataStorage.cartData.append(currentGoodItem.copyToCart())
        }
    }
    
}
