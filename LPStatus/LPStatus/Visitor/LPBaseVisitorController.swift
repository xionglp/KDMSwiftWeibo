//
//  LPBaseVisitorController.swift
//  LPStatus
//
//  Created by xlp on 2016/12/23.
//  Copyright © 2016年 xlp. All rights reserved.
//  访客视图控制器

import UIKit

class LPBaseVisitorController: UIViewController  {
    
    //定义一个bool属性，是否有登录，如果没有登录则显示访客视图，登录后则直接显示主界面
    //根据是否有userAccount信息来判断是否有登陆
    var isLogin : Bool = LPUserAccountViewModel.shareInstance.isLogin
    
    //MARK: - 懒加载方法
    lazy var visitorView : LPVisitorView = LPVisitorView.visitorView()
    
    // MARK: - 系统回调函数
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView.addAnnimation()
    }

}

// MARK: - 设置UI界面
extension LPBaseVisitorController {
    fileprivate func setupVisitorView(){
        self.view = visitorView
        
        visitorView.loginBtn .addTarget(self, action: #selector(LPBaseVisitorController.clickVisitorLoginButton), for: .touchUpInside)
        visitorView.registerBtn .addTarget(self, action: #selector(LPBaseVisitorController.clickVisitorRegisterButton), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(LPBaseVisitorController.clickVisitorRegisterButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(LPBaseVisitorController.clickVisitorLoginButton))
    }
}

// MARK: - 事件监听函数
extension LPBaseVisitorController{
    @objc fileprivate func clickVisitorRegisterButton(){
        print("点击注册按钮")
    }
    
    @objc fileprivate func clickVisitorLoginButton(){
        
        let oauthVc  = LPOauthLoginController()
        let naviVc  = UINavigationController(rootViewController: oauthVc)
        present(naviVc, animated: true) {}
    }
}
