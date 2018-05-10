//
//  UIButton-Extension.swift
//  LPStatus
//
//  Created by xlp on 2016/12/23.
//  Copyright © 2016年 xlp. All rights reserved.
//

import UIKit

// MARK: - 对按钮做一个扩展 （相当于objc的分类）
extension UIButton {
    
    //swift中类方法已class开头，相当于objc中类方法已+开头
    //扩展一个类方法
    class func createButtonToImage(imageName : String, bgImageName : String) -> UIButton{
        // 先创建一个按钮
        let extensionBtn = UIButton()
        extensionBtn.setBackgroundImage(UIImage(named:bgImageName), for: .normal)
        extensionBtn.setBackgroundImage(UIImage(named:bgImageName + "_highlighted"), for: .highlighted)
        extensionBtn.setImage(UIImage(named:imageName), for: .normal)
        extensionBtn.setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        extensionBtn.sizeToFit() // 设置按钮的尺寸，就是图片的大小
        return extensionBtn
    }
    
    //便利函数通常是写在estension的里面，init开头， init前面需要加上 convenience, 在便利构造函数中需要明确调用 self.init（）
    //convenience 关键字是用来修饰遍历构造函数的
    convenience init (imageName : String, bgImageName : String){
        self.init()
        // 当前对象的调用 self可以省略
        setBackgroundImage(UIImage(named:bgImageName), for: .normal)
        setBackgroundImage(UIImage(named:bgImageName + "_highlighted"), for: .highlighted)
        setImage(UIImage(named:imageName), for: .normal)
        setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        sizeToFit() // 设置按钮的尺寸，就是图片的大小
    }

}
