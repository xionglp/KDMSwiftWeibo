//
//  NSDate-Extension.swift
//  LPStatus
//
//  Created by xlp on 2017/5/3.
//  Copyright © 2017年 xlp. All rights reserved.
//  对时间做一个处理
// Wed May 03 16:00:03 +0800 2017

//        1分钟内: 刚刚
//        1小时内: 几(15)分钟前
//        1天内:   几(3)小时前
//        昨天:    昨天 03:24
//        一年内:  02-23 03:24
//        一年后:  2015-2-23 03:23

import Foundation

extension NSDate {
     /// 创建时间的处理
    class func createDate(create_at : String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        formatter.locale = Locale(identifier: "en") // 格式转换
        
        guard let createDate = formatter.date(from: create_at) else {
            return ""
        }
        
//        print(createDate)
        
        // 将创建时间和当前时间做比较， 用秒来比较
        
        let nowDate = Date()
        
        let interval = Int(nowDate .timeIntervalSince(createDate))
        
        if interval < 60 {
            return "刚刚"
        }
        
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        
        if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        
        // 处理 昨天: 昨天 03:24
        let calendar = NSCalendar.current
        
        let isyesterday = calendar.isDateInYesterday(createDate)
        if isyesterday {
            formatter.dateFormat = "昨天 HH:mm"
            let create_at = formatter.string(from: createDate)

            return create_at
        }
        
        // 处理 一年内: 02-23 03:24
        
        let createYear = calendar.component(.year, from: createDate)
        let nowYear = calendar.component(.year, from: nowDate)
        if createYear == nowYear {
            // 一年内
            formatter.dateFormat = "MM-dd HH:mm"
            let create_at = formatter.string(from: createDate)

            return create_at
        }
        
        // 超过一年 2015-2-23 03:23
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = formatter.string(from: createDate)

        return timeStr
    }
    
}
