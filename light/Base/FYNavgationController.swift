//
//  FYNavgationController.swift
//  qhm
//
//  Created by wang on 2019/4/12.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit

class FYNavgationController: UINavigationController,UIGestureRecognizerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.interactivePopGestureRecognizer?.delegate = self
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print(self.children.count)
        return self.children.count > 1
    }
}

// MARK: - delegate
extension FYNavgationController: UINavigationControllerDelegate {
   
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count == 0 {
            return super.pushViewController(viewController, animated: true)
        } else {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override open func popViewController(animated: Bool) -> UIViewController? {
        return  super.popViewController(animated: animated)
    }
    
}

