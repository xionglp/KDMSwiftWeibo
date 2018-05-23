//
//  LPNetworkingTools.swift
//  LPStatus
//
//  Created by xlp on 2017/4/27.
//  Copyright © 2017年 xlp. All rights reserved.
//  网络请求的一个简单的封装， 网络请求工具

enum RequestType : String {
    case GET = "GET"
    case POST = "POST"
}

import UIKit
import AFNetworking

class LPNetworkingTools: AFHTTPSessionManager {
    
    // 创建一个请求单例
    static let shareInstance : LPNetworkingTools = {
        let tools = LPNetworkingTools()
        // 相应序列化可接受的内容格式
        tools.responseSerializer.acceptableContentTypes = ["application/json", "text/json", "text/JavaScript", "text/html", "text/plain"]
        
        return tools
    }()
}

// MARK: - 网络请求方法
extension LPNetworkingTools {
    
    func request(methodType : RequestType, urlString : String, parameters : [String : AnyObject], finished : @escaping (_ result : Any?, _ error : NSError?) -> ()) {
        
        // 1.定义成功的回调闭包
        let successCallBack = { (task : URLSessionDataTask, result : Any?) -> () in
            finished(result, nil)
        }
        
        // 2.定义失败的回调闭包
        let failureCallBack = { (task: URLSessionDataTask?, error: Error) -> () in
            finished(nil, error as NSError)
        }
        
        // 3.发送网络请求
        if methodType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: successCallBack , failure: failureCallBack)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: successCallBack , failure: failureCallBack)
        }
    }
}

// MARK: - 请求accessToken
extension LPNetworkingTools {
    
    // 将code参数传进来， 将请求到的结果以闭包的形式传出去
    func requestAccessTokenData(code : String, finished: @escaping (_ result : [String : AnyObject]?, _ error : NSError?) -> ()) -> () {
        
        // key -> value
        let parameters = [
                            "client_id" : app_key,
                            "client_secret" : app_secret,
                            "grant_type" : "authorization_code",
                            "code" : code,
                            "redirect_uri" : redirect_uri
                        ];
        request(methodType: .POST, urlString: access_token_url , parameters: parameters as [String : AnyObject]) { (result,error) in
            
            finished (result as? [String : AnyObject], error)
            
        }
    }
}

// MARK: - 请求用户信息
extension LPNetworkingTools {
    func requestUserInfoData (accessToken: String, uid: String, finished: @escaping(_ result : [String : AnyObject]?, _ error : NSError?) -> ()) -> (){
        
        let parameters = ["access_token" : accessToken, "uid" : uid]
        
        request(methodType: .GET, urlString: userInfo_url, parameters: parameters as [String : AnyObject]) { (result, error) in
            
            finished (result as? [String : AnyObject], error)
        }
    }
}

// MARK: - 请求首页微博数据  //escaping 转义
extension LPNetworkingTools {
    func requestHomeStatuesData(accessToken : String, since_id: Int, max_id: Int, finished : @escaping(_ result : [[String : AnyObject]]?, _ error : NSError?) -> ()) -> () {
        let parameters = [
                        "access_token" : accessToken,
                        "since_id" : "\(since_id)",
                        "max_id" : "\(max_id)"
                        ]

        request(methodType: .GET, urlString: home_statues_url, parameters: parameters as [String : AnyObject]) { (result, error) in
            
            guard (result as? [String : AnyObject]) != nil else {
                finished (nil, error)
                return
            }
            
            let result = result as! [String : AnyObject]
            
            finished (result["statuses"] as? [[String : AnyObject]], error)
        }
        
    }
}









