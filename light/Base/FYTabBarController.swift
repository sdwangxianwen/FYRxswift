//
//  FYTabBarController.swift
//  qhm
//
//  Created by wang on 2019/4/12.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit

class FYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChild()
        
    }
    
    func setupChild() {
        let homeVC = FYHomeViewController.init()
        let meVC = FYMeViewController.init()
        let customVC = FYCustomViewController.init()
        
        addChild(homeVC, title: "首页", imageName: "", imageSelectName: "")
        addChild(customVC, title: "自定义", imageName: "", imageSelectName: "")
        addChild(meVC, title: "我的", imageName: "", imageSelectName: "")
        
    }
    
    func addChild(_ childController: UIViewController,title:String,imageName:String,imageSelectName:String) {
        let navVC = FYNavgationController.init(rootViewController: childController)
        navVC.tabBarItem = UITabBarItem.init(title: title, image:UIImage.init(named: imageName), selectedImage: UIImage.init(named: imageSelectName)?.withRenderingMode(.alwaysOriginal))
    navVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.lightGray], for: .normal)
    navVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:mainColor], for: .selected)
        
        addChild(navVC)
    }
}
