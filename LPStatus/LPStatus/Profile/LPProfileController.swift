//
//  LPProfileController.swift
//  LPStatus
//
//  Created by xlp on 2016/12/14.
//  Copyright © 2016年 xlp. All rights reserved.
//

import UIKit

class LPProfileController: LPBaseVisitorController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.setupVisitorView(imageName: "visitordiscover_image_profile", title: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
    }

}
