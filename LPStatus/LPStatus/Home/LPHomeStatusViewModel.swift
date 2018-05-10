//
//  LPHomeStatusViewModel.swift
//  LPStatus
//
//  Created by xlp on 2017/5/4.
//  Copyright © 2017年 xlp. All rights reserved.
//  微博视图模型

import UIKit

class LPHomeStatusViewModel: NSObject {
    
    var homeStatus : LPHomeStatues?
    
    // MARK: - 属性的处理
    var sourceText : String?       // 来源
    var created_at_text : String?  // 发布时间
    var verifiedImage : UIImage?   // 微博认证
    var vipImage : UIImage?        // 会员等级
    
    init(homeStatus: LPHomeStatues) {
        super.init()
        
        self.homeStatus = homeStatus
        
        // 1.来源处理
        if let source = homeStatus.source, source != "" {
            
            // "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>"
            let startLocation = (source as NSString).range(of: ">").location + 1
            let sourceLenght = (source as NSString).range(of: "</").location
            let locationText = sourceLenght - startLocation
            
            let range = NSRange(location: startLocation, length: locationText)
            
            sourceText = (source as NSString).substring(with: range)
        }
        
        // 2.时间处理
        if let create_at = homeStatus.created_at {
            // Wed May 03 16:00:03 +0800 2017
            created_at_text = NSDate .createDate(create_at: create_at)
        }
        
        // 3.会员等级处理
        if let mbrank = homeStatus.statusUser?.mbrank {
            if mbrank > 0 && mbrank <= 6 {
                vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
            }
        }
        
        // 4.微博认证处理
        if let verified_type = homeStatus.statusUser?.verified_type {
            switch verified_type {
            case 0:
                verifiedImage = UIImage(named: "avatar_vip")
            case 2,3,5:
                verifiedImage = UIImage(named: "avatar_enterprise_vip")
            case 220:
                verifiedImage = UIImage(named: "avatar_grassroot")
            default:
                verifiedImage = nil
            }
        }
    }

}
