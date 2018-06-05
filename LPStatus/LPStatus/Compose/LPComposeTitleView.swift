//
//  LPComposeTitleView.swift
//  LPStatus
//
//  Created by xlp on 2018/5/22.
//  Copyright © 2018年 xlp. All rights reserved.
//  导航栏标题

import UIKit
import SnapKit

class LPComposeTitleView: UIView {
    
    fileprivate lazy var titleL: UILabel = UILabel()
    fileprivate lazy var screenNameLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension LPComposeTitleView {
    fileprivate func setupUI() {
        self .addSubview(titleL)
        self .addSubview(screenNameLabel)
        titleL.frame = CGRect.init(x: 0, y: 0, width: 100, height: 20)
        titleL.font = UIFont.systemFont(ofSize: 16)
        titleL.textAlignment = .center
        titleL.text = "发微博"
        screenNameLabel.font = UIFont.systemFont(ofSize: 14)
        screenNameLabel.textColor = UIColor.lightGray
        screenNameLabel.frame = CGRect.init(x: 0, y: 18, width: 100, height: 20)
        screenNameLabel.textAlignment = .center
        screenNameLabel.text = LPUserAccountViewModel.shareInstance.account?.name!
    }
}
