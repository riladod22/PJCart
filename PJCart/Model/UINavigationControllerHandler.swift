//
//  UINavigationControllerHandler.swift
//  PJCart
//
//  Created by PujieLee on 2022/7/2.
//
//  自定義NavigationController

import UIKit

class PJCartNavigationController: UINavigationController {
    
    func setupAppearance() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.backgroundColor = UIColor.init(rgb: 0xDBDBDB)
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().barTintColor = UIColor.init(rgb: 0xDBDBDB)
            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
    }
}
