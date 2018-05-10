//
//  LPUserAccount.swift
//  LPStatus
//
//  Created by xlp on 2017/4/28.
//  Copyright © 2017年 xlp. All rights reserved.
//  用户信息模型

import UIKit

final class LPUserAccount : NSObject, NSCoding {
    
    //MARK: - 定义属性
    var access_token : String?   // 令牌
    var expires_in  : TimeInterval = 0.0{
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in) as Date
        }
    }
    var expires_date : Date?   // 过期时间
    var uid : String?          // 用户id
    var name : String?         // 昵称
    var avatar_large : String? // 头像
    
    // MARK: - 自定义构造函数
    convenience init(dict: [String : AnyObject]?){
        self.init()
        setValuesForKeys(dict!) // kvc
        
    }
    
     override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    // 重写description方法，
     override var description: String{
        return dictionaryWithValues(forKeys: ["access_token", "expires_date", "uid","name","avatar_large"]).description
    }
    
    //MARK: - 归档和反归档
    // 解档
    convenience required init?(coder aDecoder: NSCoder) {
        
        self.init()
        name = aDecoder.decodeObject(forKey: "name") as? String
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? Date
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
    }
    
    // 归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name,forKey:"name")
        aCoder.encode(access_token,forKey:"access_token")
        aCoder.encode(expires_date,forKey:"expires_date")
        aCoder.encode(uid,forKey:"uid")
        aCoder.encode(avatar_large,forKey:"avatar_large")
    }
    

}


