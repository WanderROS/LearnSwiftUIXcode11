//
//  ESTabBarView.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/11/7.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation
import SwiftUI
import ESTabBarController_swift

struct ESTabBarView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ESTabBarController {
        let tabBarController = ESTabBarController()
        let v1 = UINavigationController()
        let v2 = UINavigationController()
        let v3 = UINavigationController()
        let v4 = UINavigationController()
        let v5 = UINavigationController()
        
        v1.tabBarItem = UITabBarItem.init(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        v2.tabBarItem = UITabBarItem.init(title: "Find", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        v3.tabBarItem = UITabBarItem.init(title: "Photo", image: UIImage(named: "photo"), selectedImage: UIImage(named: "photo_1"))
        v4.tabBarItem = UITabBarItem.init(title: "Favor", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        v5.tabBarItem = UITabBarItem.init(title: "Me", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        
        UITabBar.appearance().tintColor = UIColor.red;
        if let tabBarItem = v2.tabBarItem as? ESTabBarItem {
             DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {
                 tabBarItem.badgeValue = "1"
             }
         }
        v3.tabBarItem.badgeValue = "4"
        tabBarController.viewControllers = [v1, v2, v3, v4, v5]

        return tabBarController;
    }
    func updateUIViewController(_ uiViewController: ESTabBarController, context: Context) {

     }
}
