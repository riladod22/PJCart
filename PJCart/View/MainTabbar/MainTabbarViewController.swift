//
//  MainTabbarViewController.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//

import UIKit

class MainTabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppDataStorage.sharedInstance.mainTabbar = self
        
        self.viewInit()
    }
    
    //MARK: process
    private func viewInit() {
        setupTabbarController()
        setupTabbarItem()
    }
    
    func swiftToLoginView(){
        self.selectedIndex = 1
    }
}

extension MainTabbarViewController {
    func setupTabbarController() {
        
        let goodsViewController = GoodsViewController.init(nibName: "GoodsViewController", bundle: Bundle.main)
        goodsViewController.title = "商品列表"
        
        let goodsNavigationController = PJCartNavigationController()
        goodsNavigationController.setupAppearance()
        goodsNavigationController.setViewControllers([goodsViewController], animated: false)
        
        let memberViewController = MemberViewController.init(nibName: "MemberViewController", bundle: Bundle.main)
        
        self.setViewControllers([goodsNavigationController,memberViewController], animated: false)
    }
    
    func setupTabbarItem() {
        if let tabBarItem1 = self.tabBar.items?[0] {
            tabBarItem1.title = "商品列表"
            tabBarItem1.image = UIImage.init(named: "goods")
        }
        if let tabBarItem2 = self.tabBar.items?[1] {
            tabBarItem2.title = "會員中心"
            tabBarItem2.image = UIImage.init(named: "member")
        }
    }
}
