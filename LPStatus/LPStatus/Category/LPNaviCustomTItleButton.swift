//
//  LPNaviCustomTItleButton.swift
//  LPStatus
//
//  Created by xlp on 2016/12/25.
//  Copyright © 2016年 xlp. All rights reserved.
//  自定义导航栏标题按钮

import UIKit

class LPNaviCustomTItleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame) //重写系统的init方法，先调用super方法
        setImage(UIImage(named:"navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named:"navigationbar_arrow_up"), for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        sizeToFit()
    }
    
    // swift中，重写init方法，必须要实现 init?(coder aDecoder: NSCoder)方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() { // titleLabel? 表示已经确定存在，强制解包
        super.layoutSubviews()
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.frame.size.width)! + 6
    }

}
