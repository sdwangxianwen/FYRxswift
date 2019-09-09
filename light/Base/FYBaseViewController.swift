//
//  FYBaseViewController.swift
//  qhm
//
//  Created by wang on 2019/4/12.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit

class FYBaseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationController?.setNavigationBarHidden(true, animated: false)
        if self.navigationController?.children.count != 1 {
            self.view.addSubview(self.navBar)
            navBar.fy_setLeftButton(title: "返回", image: UIImage.init(named: "customback")!, titleColor: UIColor.black)
            navBar.fy_setBottomLineHidden(hidden: true)
            navBar.barBackgroundColor = mainColor
        }
    }
    
    lazy var navBar = FYCustomNavigationBar.CustomNavigationBar()

    //状态栏颜色默认为黑色
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    //MARK:tableview的代理方法 和数据源
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell  = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        return cell!
    }
    

    lazy var mainTableView:UITableView = {
        let mainTableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        mainTableView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            mainTableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        return mainTableView
    }()

}

