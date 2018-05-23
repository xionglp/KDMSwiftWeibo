//
//  LPComposeTextView.swift
//  LPStatus
//
//  Created by xlp on 2018/5/22.
//  Copyright © 2018年 xlp. All rights reserved.
//

import UIKit
import SnapKit

class LPComposeTextView: UITextView {
    
    lazy var placeholdelLabel: UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}

extension LPComposeTextView {
    fileprivate func setupUI(){
        self .addSubview(placeholdelLabel)
        placeholdelLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(8)
            make.left.equalTo(10)
        }
        placeholdelLabel.font = font
        placeholdelLabel.textColor = UIColor.lightGray
        placeholdelLabel.text = "分享新鲜事..."
        
        textContainerInset = UIEdgeInsets(top: 6, left: 7, bottom: 0, right: 7)
    }
}
