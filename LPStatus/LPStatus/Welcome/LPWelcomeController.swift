//
//  LPWelcomeController.swift
//  LPStatus
//
//  Created by xlp on 2017/4/28.
//  Copyright © 2017年 xlp. All rights reserved.
//

import UIKit
import SDWebImage

class LPWelcomeController: UIViewController {
    @IBOutlet weak var iconViewToBottomConstants: NSLayoutConstraint!
    @IBOutlet weak var iconView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let avater = LPUserAccountViewModel.shareInstance.account?.avatar_large
        let iconUrl = URL(string: avater!)
        iconView.sd_setImage(with: iconUrl, placeholderImage: UIImage(named:"avatar_default_big"))
    }
    
    // 动画执行要放在这个方法里面
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // [] 代表空
        UIView.animate(withDuration: 1.0, delay: 0.25, options:[], animations: {
            // 改变约束
            self.iconViewToBottomConstants.constant = UIScreen.main.bounds.size.height - 250
            self.view.layoutIfNeeded()
        }) { (_) ->  () in
            //延时1秒执行
            let time: TimeInterval = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                UIApplication.shared.keyWindow?.rootViewController =  UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
            }
        }
    }
    
}
