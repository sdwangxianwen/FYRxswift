//
//  FYHomeViewController.swift
//  light
//
//  Created by wang on 2019/9/9.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FYHomeViewController: FYBaseViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar.isHidden = true
        post(target: .homeURL, successClosure: { (response) in
            let mode:FYHomeModel = try! response.map(FYHomeModel.self, atKeyPath: "data")
            print(mode.product_category_list)
            
        }) { (error) in
            
        }
    }
    
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        let jsonData:Data = jsonString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
        
        
    }
    
}
