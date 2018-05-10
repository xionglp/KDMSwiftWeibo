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
//    fileprivate lazy var composeBtn : UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    
    fileprivate lazy var imageNames : [String] = ["tabbar_home", "tabbar_message_center", "", "tabbar_discover", "tabbar_profile"]
    fileprivate lazy var composeBtn : UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComposeButtonToItem()
        
//        adjustItems()
    }
    

}

//MARK: - 自定义UI视图
extension LPMainTabBarController {
    //自定义tabbar item的按钮
    fileprivate func setupComposeButtonToItem(){
        tabBar .addSubview(composeBtn)
        composeBtn.center = CGPoint(x:tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        // 按钮的事件点击方法
        composeBtn .addTarget(self, action: #selector(LPMainTabBarController.addclickComposeBtn), for: .touchUpInside)
    }
    
    
    fileprivate func adjustItems() {
        /// 取出所有的item,并且设置图片
        for i in 0..<tabBar.items!.count {
            // 1.取出item
            let item = tabBar.items![i]
            
            // 2.如果是第二个,则不能和用户交互
            if i == 2 {
                item.isEnabled = false
                continue
            }
            
            // 3.设置item的图片
             item.selectedImage = UIImage(named: imageNames[i] + "_highlighted")
        }
    }
}

// MARK: - 所有事件的点击方法
extension LPMainTabBarController {
    // swift中 函数前面声明 fileprivate，则该函数不会被加到方法列表中
    // 如果在前面加上 @objc，则遵循oc的属性， 该函数会被加载到方法列表中
    @objc fileprivate func addclickComposeBtn(){
        print("addclickComposeBtn---")
    }
}

// MARK: - 通过JSON数据创建项目的TabBarItem
//extension LPMainTabBarController : UITabBarControllerDelegate {
//    // 从json文件数据中加载Class
//    fileprivate func controlletClassComeToJson(){
//
//        // 1.获取json文件的路径
//        guard let jsonPath = Bundle.main.path(forResource: "MainVCSettings", ofType: "json") else {
//            return
//        }
//        // 2.读取json文件内容
//        guard let jsonData = NSData(contentsOfFile: jsonPath) as Data? else {
//            return
//        }
//        // 3.NSData数据转成字典数组
//        guard let jsonAnyObject = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
//            return
//        }
//
//        guard let jsonDict = jsonAnyObject as? [[String : AnyObject]] else{
//            return
//        }
//
//        for dict in jsonDict {
//            guard let vcName = dict["vcName"] as? String else {
//                return
//            }
//            guard let title = dict["title"] as? String else {
//                return
//            }
//            guard let imageName = dict["imageName"] as? String else {
//                return
//            }
//            addChildViewController(childName: vcName, title: title, imageName: imageName)
//
//        }
//    }
//
//    // 根据字符串获取对应的Class
//    fileprivate func addChildViewController(childName: String, title: String, imageName: String){
//
//        // 获取命名空间
//        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
//            print("没有获取到命名空间")
//            return
//        }
//
//        // 根据字符串获取对应的Class
//        guard let childVcName = NSClassFromString(nameSpace + "." + childName) else {
//            print("没有获取到对应的Class")
//            return
//        }
//
//        // 将对应的anyObject转成控制器类型
//        guard let childVcTyep = childVcName as? UIViewController.Type else {
//            print("没有转成控制器类型")
//            return
//        }
//
//        // 创建控制器
//        let childVc = childVcTyep.init()
//
//        childVc.title = title
//        childVc.view.backgroundColor = UIColor.white
//        childVc.tabBarItem.image = UIImage(named:imageName)
//        childVc.tabBarItem.selectedImage = UIImage(named: imageName +  "_highlighted") // 直接相加
//
//        let childNav = UINavigationController(rootViewController:childVc)
//        addChildViewController(childNav)
//    }
//
//    // private 函数方法私有化 在当前文件中能调用， 别的地方不能调用
//    fileprivate func addChildViewController(childVc: UITableViewController, title: String, inmageName: String){
//        let childVc = childVc
//        childVc.title = title
//        childVc.view.backgroundColor = UIColor.white
//        childVc.tabBarItem.image = UIImage(named:inmageName)
//        childVc.tabBarItem.selectedImage = UIImage(named: inmageName +  "_highlighted") // 直接相加
//        let childNav = UINavigationController(rootViewController:childVc)
//        addChildViewController(childNav)
//    }
//}



