//
//  FYCustomViewController.swift
//  light
//
//  Created by wang on 2019/9/9.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit

class FYCustomViewController: FYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(selectBtn)
        
    }
    
    lazy var selectBtn = {()->UIButton in
        let selectBtn = UIButton.init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        return selectBtn
    }()
    
}
