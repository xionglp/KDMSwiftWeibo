//
//  LPCommonConstant.swift
//  LPStatus
//
//  Created by xlp on 2017/4/28.
//  Copyright © 2017年 xlp. All rights reserved.
//

import Foundation

// MARK:- 授权的常量
let app_key = "1284488322"
let app_secret = "eaf70a12e4fc817d6b6ebe1d92633d7e"
let redirect_uri = "http://www.baidu.com"

//MARK:- 请求接口路径
//公有url前缀
let common_url = "https://api.weibo.com/"
// oauth授权
let oauth_url = "\(common_url)oauth2/authorize?"
// 获取accessToken
let access_token_url = "\(common_url)oauth2/access_token"
// 用户信息
let userInfo_url = "\(common_url)2/users/show.json"
// 用户登录账号下的最新微博
let home_statues_url = "\(common_url)2/statuses/home_timeline.json"
//发送微博
let send_statues_url = "\(common_url)2/statuses/update.json"

//MARK:- 通知名称常量
//选择照片的通知常量
let picPickerNotificationName = Notification.Name(rawValue: "DownloadImageNotification")
let deletePictureNotificationName = Notification.Name(rawValue: "deletePictureNotificationName")




