//
//  AppDelegate.swift
//  LPStatus
//
//  Created by xlp on 2016/12/14.
//  Copyright © 2016年 xlp. All rights reserved.
//  初始化3232

///Users/xiongluping/Library/Developer/CoreSimulator/Devices/2739A010-BCAF-46E7-B5E8-AC0F355F7400/data/Containers/Data/Application/D88D60CD-3069-42C9-9DC4-90371220338B/Documents/

import UIKit
import Bugly

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userAccount: LPUserAccount?
    
    // 1.计算属性， 判断是否有登陆过， 登陆过， 进来显示欢迎界面，然后再显示主界面，
    // 2.没有登录过， 直接显示Main控制器，到访客视图
    // 3.访客视图，点击登录按钮到oauth授权登录页面，登录成功后（islogin = true）到欢迎页面进入主页
    var defaultController : UIViewController {
        let isLogin = LPUserAccountViewModel.shareInstance.isLogin
        return isLogin ? LPWelcomeController () : UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {        //程序启动完加载此方法

//        Bugly.start(withAppId: "defca9f64f")//腾讯bugly错误统计
        
        UITabBar.appearance().tintColor = UIColor.orange        // 设置全局的tabBar的颜色
        UINavigationBar.appearance().tintColor = UIColor.orange // 设置全局的NavigationBar的颜色
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = defaultController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

