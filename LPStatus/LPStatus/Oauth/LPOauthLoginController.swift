//
//  LPOauthLoginController.swift
//  LPStatus
//
//  Created by xlp on 2017/4/28.
//  Copyright © 2017年 xlp. All rights reserved.
//  授权控制器

import UIKit
import SVProgressHUD

class LPOauthLoginController: UIViewController {

    // MARK: 定义属性
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        loadOauthPage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: 设置界面相关
extension LPOauthLoginController {
    
    // 设置导航栏
    fileprivate func setupNavigationBar() -> () {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(LPOauthLoginController.closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style:.plain, target: self, action: #selector(LPOauthLoginController.fillUserAccount))
        title = "登录页面"
    }
    
    // 加载授权界面
    fileprivate func loadOauthPage(){
        let urlString = "\(oauth_url)client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        
        let oauthUrl = URL(string: urlString)
        let oauthRequest = URLRequest(url: oauthUrl!) // 确认存在， 强制解包
        
        webView.loadRequest(oauthRequest)
    }
}

// MARK: 点击事件
extension LPOauthLoginController {
    // 关闭登录控制器
    @objc fileprivate func closeItemClick () {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    //填充用户信息
    @objc fileprivate func fillUserAccount () {
        let jsCode = "document.getElementById('userId').value='785874752@qq.com';document.getElementById('passwd').value='xiong000615';"
        
        // 2.执行js代码
        webView .stringByEvaluatingJavaScript(from: jsCode)
    }
}

// MARK: webview代理方法
extension LPOauthLoginController : UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        print(request)
        
        // 获取加载网页的url
        guard let oauthUrl = request.url else {
            return true
        }
        
        let urlStr = oauthUrl.absoluteString
        
        guard urlStr.contains("code=") else {
            return true
        }
        
        // 将code截取出来  604037c68fcb83b1ad472f7ebfa54196
        let codeStr = urlStr.components(separatedBy: "code=").last!
        
        questAccessToken(code: codeStr)
        
        return false
    }
    
}

// MARK: 网络请求
extension LPOauthLoginController {
    
    /// 请求acccess_token
    fileprivate func questAccessToken(code : String) -> () {
        LPNetworkingTools.shareInstance.requestAccessTokenData(code: code) { (result : [String : AnyObject]?, error : NSError?) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            guard let result = result else {
                return
            }
            
            let account = LPUserAccount(dict: result)
            print(account)
            
            // 请求用户信息 , 在闭包里面调用函数需要加上self.***
            self.requestUserInfo(account: account)
        }
    }
    
    ///请求用户信息
    fileprivate func requestUserInfo (account : LPUserAccount) -> (){
        guard let accessToken = account.access_token else {
            return
        }
        
        guard let uid = account.uid else {
            return
        }
        LPNetworkingTools.shareInstance.requestUserInfoData(accessToken: accessToken, uid: uid) { (result : [String : AnyObject]?, error : NSError?) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            guard let userInfoDict = result else {
                return
            }
            
            print(result ?? "")
            account.name = userInfoDict["name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
            
            print(account)
            
            //1. 将账户信息归档保存起来
            let accountPath = LPUserAccountViewModel.shareInstance.accountPath
            print(accountPath)
            // 归档必须在模型里面实现encoder，Decoder方法
            NSKeyedArchiver.archiveRootObject(account, toFile: accountPath)
            
            // 将对象赋值到单例对象里面去， 否则LPWelcomeController里面拿不到对象数据
            LPUserAccountViewModel.shareInstance.account = account
            
            // 来到欢迎界面
            self.dismiss(animated: false, completion: { 
                UIApplication.shared.keyWindow?.rootViewController = LPWelcomeController()
            })
        }
    }
}
