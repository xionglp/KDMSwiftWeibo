//
//  LPPresentationController.swift
//  LPStatus
//
//  Created by xlp on 2016/12/25.
//  Copyright © 2016年 xlp. All rights reserved.
//

import UIKit

class LPPresentationController: UIPresentationController {
    
    //MARK: - 懒加载
    lazy var maskView : UIView = UIView()
    
    lazy var naviBarBtn : LPNaviCustomTItleButton = LPNaviCustomTItleButton()
    
    //MARK: - 系统回调函数
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView?.frame = CGRect(x: ((presentedView?.frame.size.width)! - 180) * 0.5, y: 55, width: 180, height: 250)
        
        setupMaskView()
    }
    

}

// MARK: - 设置UI界面
extension LPPresentationController{
    
    fileprivate func setupMaskView(){
        containerView!.insertSubview(maskView, at: 0)
        maskView.backgroundColor = UIColor.init(white: 0.8, alpha: 0.15)
        maskView.frame = (containerView?.bounds)!
        let tap = UITapGestureRecognizer(target: self, action: #selector(LPPresentationController.clickPresentViewMask))
        maskView.addGestureRecognizer(tap)
    }
}

//MARK: - 事件点击函数
extension LPPresentationController {
    @objc fileprivate func clickPresentViewMask(){
        
        naviBarBtn.isSelected = false;
        
        presentedViewController .dismiss(animated: true, completion: nil)
    }
}
