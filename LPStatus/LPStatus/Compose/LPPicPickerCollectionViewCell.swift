//
//  LPPicPickerCollectionViewCell.swift
//  LPStatus
//
//  Created by xlp on 2018/5/23.
//  Copyright © 2018年 xlp. All rights reserved.
//

import UIKit

class LPPicPickerCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func clickAddPicture(_ sender: Any) {
        //多层传递不适合用代理和闭包，可以用通知
        NotificationCenter.default.post(name: picPickerNotificationName, object: nil)
    }
    
    @IBAction func clickDelectPicture(_ sender: Any) {
        
    }
}
