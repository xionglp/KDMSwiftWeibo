//
//  LPMainTabBarController.swift
//  LPStatus
//
//  Created by xlp on 2016/12/14.
//  Copyright © 2016年 xlp. All rights reserved.
//  tabbar控制器

import UIKit

class LPMainTabBarController: UITabBarController {
    
    //MARK: -  懒加载一个按钮 (通过自定义类方法)
    fileprivate lazy var composeBtn : UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //在自定义的button覆盖tabbar时， 按钮的事件会出现不响应， 解决方案就是将按钮在viewWillAppear方法中添加
        setupComposeButtonToItem()
    }
}

//MARK: - 自定义UI视图
extension LPMainTabBarController {
    //自定义tabbar item的按钮
    fileprivate func setupComposeButtonToItem(){
        tabBar .addSubview(composeBtn)
        composeBtn.center = CGPoint(x:tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        // 按钮的事件点击方法
        composeBtn.addTarget(self, action: #selector(LPMainTabBarController.addclickComposeBtn), for:.touchUpInside)
    }
}

// MARK: - 所有事件的点击方法
extension LPMainTabBarController {
    // swift中 函数前面声明 fileprivate，则该函数不会被加到方法列表中
    // 如果在前面加上 @objc，则遵循oc的属性， 该函数会被加载到方法列表中
    @objc fileprivate func addclickComposeBtn(){
        let composeVc = LPComposeViewController()
        composeVc.view.backgroundColor = UIColor.white
        let composeNavc = UINavigationController.init(rootViewController: composeVc)
        self .present(composeNavc, animated: true, completion: nil)
    }
}


