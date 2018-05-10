//
//  UIBarButtonItem-Extension.swift
//  LPStatus
//
//  Created by xlp on 2016/12/24.
//  Copyright © 2016年 xlp. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    // 扩充一些便利构造函数
    convenience init(inageName:String){
        self.init()
        let barItemBtn = UIButton()
        barItemBtn .setBackgroundImage(UIImage(named:inageName), for: .normal)
        barItemBtn .setBackgroundImage(UIImage(named:inageName + "_highlighted"), for: .highlighted)
        barItemBtn.sizeToFit() // 按钮的大小就是图片的尺寸
        self.customView = barItemBtn
    }
}
