//
//  LPHomeUser.swift
//  LPStatus
//
//  Created by xlp on 2017/5/4.
//  Copyright © 2017年 xlp. All rights reserved.
//  微博数据，用户对象

//  对象就是用来存储数据， 不要将数据的处理放在对象中来处理， 可以放在视图模型中
//  视图模型相当于tools， 本质来说也是一个模型对象

import UIKit

class LPHomeUser: NSObject {

    // MARK:- 属性
    var profile_image_url : String?         // 用户的头像
    var screen_name : String?               // 用户的昵称
    var verified_type : Int = -1            // 用户的认证类
    var mbrank : Int = 0                    // 用户的会员等级
    
    // MARK: - 方法
    init(dict: [String : AnyObject]) {
        super.init()
        
        // KVC
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
