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
        
        titleL.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top)
        }
        titleL.backgroundColor = UIColor.red
        
        screenNameLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(titleL.snp.centerX)
            make.top.equalTo(titleL.snp.bottom).offset(3)
        }
        screenNameLabel.backgroundColor = UIColor.blue
        
        titleL.font = UIFont.systemFont(ofSize: 16)
        screenNameLabel.font = UIFont.systemFont(ofSize: 14)
        screenNameLabel.textColor = UIColor.lightGray
        
        titleL.text = "发微博"
        screenNameLabel.text = LPUserAccountViewModel.shareInstance.account?.name!
        
    }
}
