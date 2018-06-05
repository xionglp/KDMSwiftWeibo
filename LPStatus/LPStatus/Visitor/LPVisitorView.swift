//
//  LPVisitorView.swift
//  LPStatus
//
//  Created by xlp on 2016/12/23.
//  Copyright © 2016年 xlp. All rights reserved.
//  访客视图的View

import UIKit

class LPVisitorView: UIView {
    
    @IBOutlet weak var ratationView: UIImageView!  // 转盘
    @IBOutlet weak var iconView: UIImageView!      // 图标
    @IBOutlet weak var visitorLabel: UILabel!      // 描述信息
    @IBOutlet weak var registerBtn: UIButton!      // 注册按钮
    @IBOutlet weak var loginBtn: UIButton!         // 登录按钮
    
    // 提供一个快速创建xib的类方法
    class func visitorView() -> LPVisitorView{
        return Bundle.main .loadNibNamed("LPVisitorView", owner: nil, options: nil)?.first as! LPVisitorView
    }
    
    func setupVisitorView(imageName : String, title : String){
        iconView.image = UIImage(named: imageName)
        visitorLabel.text = title
        ratationView.isHidden = true
    }
    
    func addAnnimation(){
        //创建一个动画
        let annimation = CABasicAnimation(keyPath: "transform.rotation.z")
        //设置动画属性
        annimation.fromValue = 0
        annimation.toValue = Double.pi * 2
        annimation.repeatCount = Float(MAXFLOAT)
        annimation.duration = 6
        annimation.isRemovedOnCompletion = false
        //将动画添加到layer上面
        ratationView.layer.add(annimation, forKey: nil)
    }

}
