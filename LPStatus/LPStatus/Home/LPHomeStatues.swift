//
//  LPHomeStatues.swift
//  LPStatus
//
//  Created by xlp on 2017/5/3.
//  Copyright © 2017年 xlp. All rights reserved.
//  首页微博数据模型

import UIKit

class LPHomeStatues: NSObject {
    
    // MARK:- 属性
    var created_at: String?                // 微博创建时间
    var source: String?                    // 微博来源
    var text: String?                      // 微博的正文
    var mid: Int = 0                       // 微博的ID
    var statusUser: LPHomeUser?            // 微博用户
    
    // MARK: - 方法
    convenience init(dict: [String : AnyObject]) {
        self.init()
        setValuesForKeys(dict)
        
        // 将微博用户字典转成用户模型
        if let statusDict = dict["user"] as? [String : AnyObject] {
            statusUser = LPHomeUser(dict: statusDict)
        }
    }
    
    /// 利用kvc将字典转模型， 有些key没有用到，必须要调用这个方法  Undefined: 不明确的
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    /// 重写description方法，
    override var description: String{
        return dictionaryWithValues(forKeys: ["created_at","created_at_text", "source", "sourceText","text","statusUser"]).description
    }


}
