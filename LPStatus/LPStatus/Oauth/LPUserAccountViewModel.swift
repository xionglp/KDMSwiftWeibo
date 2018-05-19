//
//  LPUserAccountViewController.swift
//  LPStatus
//
//  Created by xlp on 2017/4/28.
//  Copyright © 2017年 xlp. All rights reserved.
//  MVVM

import UIKit

class LPUserAccountViewModel {
    
    static let shareInstance : LPUserAccountViewModel = LPUserAccountViewModel()
    
    var account : LPUserAccount?
    
    // 计算属性
    var accountPath : String {
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        return (accountPath! as NSString).appendingPathComponent("account.plist")
    }
    
    var isLogin : Bool {
        if account == nil {
            return false
        }
        guard ((account?.expires_date) != nil) else {//校验
            return false
        }
        return account?.expires_date?.compare(Date()) == ComparisonResult.orderedDescending
    }
    
     // 反归档，拿到账号信息
    init() {
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? LPUserAccount
        print(account?.access_token)
    }
    
}
