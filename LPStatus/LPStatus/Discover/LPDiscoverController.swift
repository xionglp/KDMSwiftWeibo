//
//  LPDiscoverController.swift
//  LPStatus
//
//  Created by xlp on 2016/12/14.
//  Copyright © 2016年 xlp. All rights reserved.
//

import UIKit

class LPDiscoverController: LPBaseVisitorController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.setupVisitorView(imageName: "visitordiscover_image_message", title: "登录后，别人评论你的微博，给你发消息，都会在这里收到通知")
        
    }

    
}
